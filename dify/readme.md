# Langgenius Dify on CUDO Compute
Deploy this application using our Apps feature in your project on CUDO compute. 

Read the [docs here!](https://www.cudocompute.com/docs/apps/dify)

# Dify
Langgenius Dify is a cutting-edge platform designed to enhance the capabilities of large language 
models (LLMs) by integrating them with external tools and resources. This integration allows Dify to 
autonomously perform complex tasks, such as web browsing and data gathering, with precision and 
efficiency. By leveraging advanced reasoning and adaptive capabilities, Dify enables LLMs to think 
critically and execute multi-step operations, making it an invaluable tool for developers and 
enterprises looking to harness the full potential of AI. The platform's ability to gather real-time 
information and iterate on tasks ensures that users can achieve high levels of accuracy and 
effectiveness in their AI-driven projects. Whether used for research, development, or deployment,
Langgenius Dify offers a robust solution for enhancing AI workflows and achieving superior outcomes.

# Cudo Compute
Cudo Compute is a powerful cloud infrastructure platform offering on-demand and cost-effective access to cloud GPUs and high-performance computing (HPC) resources.
Ideal for AI model training, machine learning (ML), deep learning (DL), and data science, Cudo Compute provides flexible and scalable GPU rental services. 
With support for NVIDIA A100, H100, H200, A6000 and other top-tier GPUs, it’s perfect for running intensive AI workloads, LLM fine-tuning, and inference. 
Whether you need GPU cloud instances for parallel processing, rendering, or scientific simulations, Cudo Compute offers a reliable, low-latency solution. 
The platform is a top choice for startups, enterprises, and developers seeking cost-efficient, high-performance cloud computing.

# Manual deploy
Only use the command below; if you wish to deploy manually:

```shell
wget -qO - https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main/install-compose-service.sh | bash -s dify
```