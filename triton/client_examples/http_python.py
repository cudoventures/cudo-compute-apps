#https://github.com/triton-inference-server/client/blob/main/src/python/examples/simple_http_model_control.py
import tritonclient.http as httpclient
from tritonclient.utils import InferenceServerException
import sys
import numpy as np


IP_ADDRESS = 'CUDO_IP_ADDRESS'
KEY = 'CUDO_APP_KEY'

class AuthKeyPlugin():
  def __call__(self, request):
       request.headers['apikey'] = KEY

def get_client():
    try:
        triton_client = httpclient.InferenceServerClient(
            url=IP_ADDRESS + '/triton-http', verbose=True
        )
    except Exception as e:
        print("context creation failed: " + str(e))
        sys.exit()

    # Register the plugin
    auth_plugin = AuthKeyPlugin()
    triton_client.register_plugin(auth_plugin)
    return triton_client

def simple_string_inference(triton_client):
    model_name = "simple_string"

    inputs = []
    outputs = []
    inputs.append(httpclient.InferInput("INPUT0", [1, 16], "BYTES"))
    inputs.append(httpclient.InferInput("INPUT1", [1, 16], "BYTES"))

    # Create the data for the two input tensors. Initialize the first
    # to unique integers and the second to all ones.
    in0 = np.arange(start=0, stop=16, dtype=np.int32)
    in0 = np.expand_dims(in0, axis=0)
    in1 = np.ones(shape=(1, 16), dtype=np.int32)
    expected_sum = np.add(in0, in1)
    expected_diff = np.subtract(in0, in1)

    # The 'simple_string' model expects 2 BYTES tensors where each
    # element in those tensors is the utf-8 string representation of
    # an integer. The BYTES tensors must be represented by a numpy
    # array with dtype=np.object_.
    in0n = np.array(
        [str(x).encode("utf-8") for x in in0.reshape(in0.size)], dtype=np.object_
    )
    input0_data = in0n.reshape(in0.shape)
    in1n = np.array(
        [str(x).encode("utf-8") for x in in1.reshape(in1.size)], dtype=np.object_
    )
    input1_data = in1n.reshape(in1.shape)

    # Initialize the data
    inputs[0].set_data_from_numpy(input0_data, binary_data=True)
    inputs[1].set_data_from_numpy(input1_data, binary_data=False)

    outputs.append(httpclient.InferRequestedOutput("OUTPUT0", binary_data=True))
    outputs.append(httpclient.InferRequestedOutput("OUTPUT1", binary_data=False))

    results = triton_client.infer(model_name=model_name, inputs=inputs, outputs=outputs)

    # Get the output arrays from the results
    output0_data = results.as_numpy("OUTPUT0")
    output1_data = results.as_numpy("OUTPUT1")

    for i in range(16):
        print(
            str(input0_data[0][i])
            + " + "
            + str(input1_data[0][i])
            + " = "
            + str(output0_data[0][i])
        )
        print(
            str(input0_data[0][i])
            + " - "
            + str(input1_data[0][i])
            + " = "
            + str(output1_data[0][i])
        )

        # Convert result from string to int to check result
        r0 = int(output0_data[0][i])
        r1 = int(output1_data[0][i])
        if expected_sum[0][i] != r0:
            print("error: incorrect sum")
            sys.exit(1)
        if expected_diff[0][i] != r1:
            print("error: incorrect difference")
            sys.exit(1)

def main():
    triton_client = get_client()
    model_name = "simple"
    # Health
    if not triton_client.is_server_live(query_params={"test_1": 1, "test_2": 2}):
        print("FAILED : is_server_live")
        sys.exit(1)

    if not triton_client.is_server_ready():
        print("FAILED : is_server_ready")
        sys.exit(1)

    if not triton_client.is_model_ready(model_name):
        print("FAILED : is_model_ready")
        sys.exit(1)

    # Metadata
    metadata = triton_client.get_server_metadata()
    if not (metadata["name"] == "triton"):
        print("FAILED : get_server_metadata")
        sys.exit(1)
    print(metadata)

    metadata = triton_client.get_model_metadata(
        model_name, query_params={"test_1": 1, "test_2": 2}
    )
    if not (metadata["name"] == model_name):
        print("FAILED : get_model_metadata")
        sys.exit(1)
    print(metadata)

    # Passing incorrect model name
    try:
        metadata = triton_client.get_model_metadata("wrong_model_name")
    except InferenceServerException as ex:
        if "Request for unknown model" not in ex.message():
            print("FAILED : get_model_metadata wrong_model_name")
            sys.exit(1)
    else:
        print("FAILED : get_model_metadata wrong_model_name")
        sys.exit(1)

    simple_string_inference(triton_client)

main()


