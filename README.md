# Enterprise RAG Knowledge Assistant

## Executive summary
Enterprise teams often store critical policies, runbooks, and operational knowledge across unstructured documents that are hard to search quickly and reliably. This project implements a recruiter-ready, full-stack Retrieval-Augmented Generation (RAG) assistant that ingests documents, chunks and indexes them, retrieves evidence with hybrid search, and returns grounded answers with source citations. The system is designed for local, reproducible development using deterministic embeddings and heuristic answer synthesis, while keeping clear extension points for production-grade model providers.

## Key features
- **Document ingestion pipeline** with upload endpoints, content extraction support, and chunking logic that combines semantic boundaries with fallback sliding windows.
- **Embedding + indexing workflow** using deterministic hash-based embeddings and runtime vector search via FAISS-backed indexing services.
- **Hybrid retrieval** that combines vector similarity, lexical keyword scoring, and metadata-aware signals.
- **Weighted reranking pipeline** to reorder candidates before answer assembly.
- **Grounded answer generation** that composes responses from retrieved evidence and includes chunk-level citations/source traceability.
- **Evidence-aware guardrails** that return insufficient-evidence responses when confidence is low.
- **Enterprise-oriented API surface** for auth, documents, chat, search, and admin metrics.
- **Role-aware and organization-aware behavior** through JWT auth, RBAC patterns, and org-scoped retrieval/data access.
- **Frontend interface** for login, dashboard, document management, chat, and settings pages.

## Tech stack
- **Backend:** Python, FastAPI, SQLAlchemy, Pydantic, Alembic
- **Frontend:** React, Vite, Tailwind CSS
- **Data & retrieval:** SQLite by default (PostgreSQL optional), FAISS-style vector index service, hybrid lexical/vector retrieval
- **Security & platform concerns:** JWT-based auth, CORS configuration, in-memory rate limiting, request/usage metrics middleware
- **Developer workflow:** Docker Compose, Makefile automation, pytest-based backend tests

## System architecture overview
The platform follows a modular service-oriented backend with clear boundaries between ingestion, embeddings, retrieval, reranking, and answer assembly.

1. **Ingest documents** through API endpoints and persist document metadata/content.
2. **Chunk content** into retrievable units using semantic splitting with overlap-aware fallbacks.
3. **Generate embeddings** for chunks using a deterministic embedding service.
4. **Index vectors** and persist chunk/embedding records for retrieval.
5. **Retrieve candidates** with hybrid vector + keyword search, including metadata features.
6. **Rerank candidates** using weighted retrieval features.
7. **Assemble grounded answers** from top evidence snippets and return citations.
8. **Expose responses in UI/API** with latency, confidence, and evidence indicators.

## How retrieval-augmented generation works in this project
This repository implements a practical RAG pattern focused on **traceability and reproducibility**:

- A user query is embedded and searched against indexed chunk vectors.
- A lexical retrieval pass scores keyword overlap in chunk content, titles, and source names.
- Scores are blended and reranked to produce the final evidence set.
- The answer service evaluates evidence sufficiency and either:
  - returns an insufficient-evidence/low-confidence fallback, or
  - generates a grounded heuristic response from top citations.
- Each answer includes source references (document/chunk context) so users can verify claims against original material.

> Note: By default, this project does **not** call an external hosted LLM for generation; it uses a local heuristic grounded-answer composer.

## Setup and installation instructions
### Option A: Local development (without Docker)
1. Install dependencies:
   ```bash
   make bootstrap
   ```
2. Initialize the database and seed demo data:
   ```bash
   make init
   ```
3. Start backend:
   ```bash
   make run-backend
   ```
4. Start frontend in another terminal:
   ```bash
   make run-frontend
   ```
5. Open:
   - Frontend: `http://localhost:5173`
   - API docs: `http://localhost:8000/docs`

### Option B: Docker Compose
```bash
make dev
```

### Demo credentials
- `admin@calisto.ai` / `password123`
- `member@calisto.ai` / `password123`
- `viewer@calisto.ai` / `password123`

### Useful commands
- Run tests/build checks:
  ```bash
  make test
  ```
- Run smoke test script:
  ```bash
  make smoke-test
  ```
- Run retrieval evaluation script:
  ```bash
  python scripts/evaluate_retrieval.py
  ```

## Example use cases
- **AI Engineering:** Prototype and evaluate RAG pipelines with clear service boundaries and provider swap points.
- **Data Science / IR:** Experiment with chunking strategies, hybrid retrieval scoring, and reranking behavior on enterprise-style corpora.
- **Enterprise Search:** Build an internal knowledge assistant for policies, handbooks, runbooks, and operational documentation.
- **Platform/API Engineering:** Extend a FastAPI-based knowledge service with auth, metrics, and admin endpoints.

## What I learned / skills demonstrated
- Designing and implementing an end-to-end RAG data pipeline (ingestion → chunking → embeddings → indexing → retrieval → answer assembly).
- Building a production-structured Python API codebase with routers, services, models, and schemas.
- Implementing hybrid search and scoring logic that blends vector, lexical, and metadata signals.
- Prioritizing explainability through citation-grounded outputs and low-confidence safeguards.
- Developing full-stack integrations between a React frontend and a modular FastAPI backend.
- Working with migration tooling, test automation, and containerized local environments.

## Resume-ready project description
Built a full-stack **Enterprise RAG Knowledge Assistant** using **Python (FastAPI), SQLAlchemy, React, and FAISS-style vector indexing** to ingest unstructured documents, generate embeddings, perform hybrid semantic/lexical retrieval, rerank evidence, and deliver citation-grounded answers for enterprise knowledge search workflows. Implemented modular API services, JWT-based authentication, organization-aware access patterns, and evaluation scripts to support reproducible experimentation and portfolio-grade system design.

## Future improvements
- Integrate production embedding providers (e.g., sentence-transformer or hosted embeddings) while preserving current interfaces.
- Add configurable LLM backends for answer generation beyond heuristic composition.
- Persist and scale vector infrastructure for larger multi-tenant corpora.
- Expand retrieval evaluation with richer benchmark datasets and relevance metrics dashboards.
- Add deeper observability around retrieval quality, latency, and failure modes.

## Additional docs
- Architecture notes: [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)
- API overview: [`docs/API.md`](docs/API.md)
- Chunking details: [`docs/chunking-strategy.md`](docs/chunking-strategy.md)
- Demo runbook: [`docs/DEMO_RUNBOOK.md`](docs/DEMO_RUNBOOK.md)

## License
MIT (see [`LICENSE`](LICENSE)).
