






Deploying LangGenius Dify with Ollama requires selecting appropriate models for various tasks, considering both performance and GPU memory constraints. Below is an overview of each model type, along with suggested models suitable for GPUs with 24 GB, 48 GB, and 80 GB of VRAM.

---

## System Reasoning Model

**Purpose:** Handles general-purpose language understanding and generation tasks

**Considerations:** Model size directly impacts GPU memory usage. Larger models offer better performance but require more VRAM


| Model             | Parameters | VRAM Requirement | Suitable GPU |
|-------------------|------------|------------------|--------------|
| Mistral           | 7B         | ~8–12 GB         | 24 GB        |
| DeepSeek-R1       | 7B         | ~16 GB           | 24 GB        |
| LLaMA 3.1         | 8B         | ~12 GB           | 24 GB        |
| LLaMA 3.1         | 70B        | ~40 GB           | 48 GB        |
| DeepSeek-R1       | 32B        | ~48 GB           | 48 GB        |
| LLaMA 3.1         | 405B       | ~231 GB          | 80 GB+       |

---

## Embedding Model

**Purpose:* Generates vector representations of text for tasks like semantic search and clusterin.


| Model                   | VRAM Requirement | Suitable GPU |
|-------------------------|------------------|--------------|
| text-embedding-ada-002  | ~1–2 GB          | 24 GB        |
| BGE-Large               | ~4–6 GB          | 24 GB        |
| Instructor-XL           | ~6–8 GB          | 24 GB       |


---

## Rerank Model

**Purpose:* Reorders search results based on relevance, improving the quality of retrieved informatin.

| Model         | VRAM Requirement | Suitable GPU |
|---------------|------------------|--------------|
| Cross-Encoder | ~2–4 GB          | 24 GB        |
| MiniLM        | ~2 GB            | 24 GB       |

*Note* Rerank models are typically small and can be deployed on GPUs with 24 GB of VRM.

---

**Purpose** Converts spoken language into written text.

**Suggested Models:*

| Model      | VRAM Requirement | Suitable GPU |
|------------|------------------|--------------|
| Whisper-1  | ~10 GB           | 24 GB        |
| Whisper-Large | ~16 GB        | 24 GB       |

*Note:* Whisper models are optimized for performance and can run on GPUs with 24 GB of VAM.

---
**Purpose:** Generates spoken audio from text input.

**Suggested Models**

| Model           | VRAM Requirement | Suitable GPU  |
|-----------------|------------------|---------------|
| EfficientSpeech | ~1 GB            | 24 GB         |
| R-MelNet        | ~11 GB           | 24 GB         |