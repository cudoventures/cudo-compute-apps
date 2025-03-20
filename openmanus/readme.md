# OpenManus on CUDO Compute
Deploy this application using our Apps feature in your project on CUDO compute. 

Read the [docs here!](https://www.cudocompute.com/docs/apps/openmanus)

# OpenManus
OpenManus is an open-source AI agent designed to connect large language models (LLMs) with external tools, 
such as web browsers, to autonomously carry out complex tasks. 
With the ability to iterate, reason, and adapt, OpenManus enhances the capabilities of LLMs by enabling them to think 
critically, gather real-time information, and execute multi-step operations with precision.

# Cudo Compute
Cudo Compute is a powerful cloud infrastructure platform offering on-demand and cost-effective access to cloud GPUs and high-performance computing (HPC) resources.
Ideal for AI model training, machine learning (ML), deep learning (DL), and data science, Cudo Compute provides flexible and scalable GPU rental services. 
With support for NVIDIA A100, H100, H200, A6000 and other top-tier GPUs, it’s perfect for running intensive AI workloads, LLM fine-tuning, and inference. 
Whether you need GPU cloud instances for parallel processing, rendering, or scientific simulations, Cudo Compute offers a reliable, low-latency solution. 
The platform is a top choice for startups, enterprises, and developers seeking cost-efficient, high-performance cloud computing.

# Manual deploy
Only use the command below; if you wish to deploy manually:

```shell
wget -qO - https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main/install-compose-service.sh | bash -s openmanus
```