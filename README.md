# Enterprise RAG Knowledge Assistant

## Executive summary
Enterprise knowledge is often fragmented across policy docs, runbooks, and operational files. That fragmentation makes fast, reliable internal search difficult for teams. This project provides a full-stack Retrieval-Augmented Generation (RAG) assistant that ingests documents, chunks and indexes content, retrieves evidence with semantic and lexical signals, and returns grounded responses with citations in a reproducible local setup.

## Key features
- Document ingestion for `txt`, `md`, and `pdf` content (including base64 file upload flow).
- Chunk preview and configurable chunking (semantic splitting with overlap-aware sliding-window fallback).
- Deterministic embedding generation and persisted chunk embeddings.
- Hybrid retrieval (vector similarity + keyword scoring + metadata scoring) with weighted reranking.
- Grounded heuristic answer composition with citation objects, source previews, and chunk-level traceability.
- Evidence-aware fallbacks (`insufficient_evidence` / low-confidence mode) and confidence scoring.
- Query rewrite, prompt-injection text sanitization, and optional PII redaction before indexing.
- JWT auth, role-aware access control (admin/member/viewer), and organization-scoped document/query behavior.
- Admin analytics endpoints and dashboard views for ingestion, usage, feedback, benchmark, collections, and audit logs.

## Tech stack
- **Backend:** Python, FastAPI, SQLAlchemy, Pydantic, Alembic
- **Frontend:** React, Vite, Tailwind CSS
- **Retrieval/IR libraries:** NumPy, rank-bm25, FAISS
- **Data:** SQLite by default (`DATABASE_URL` supports other DBs such as PostgreSQL)
- **Security/platform:** JWT auth, CORS middleware, in-memory rate limiting, request metrics/logging
- **Tooling:** Makefile workflow, pytest, Ruff, ESLint, Docker Compose

## System architecture overview
1. Users upload raw content or files through the documents API/UI.
2. Content extraction normalizes text (including PDF extraction), with optional PII redaction.
3. Ingestion jobs chunk documents and generate embeddings for each chunk.
4. Chunks and embeddings are stored in the relational database.
5. Query handling rewrites the question, applies organization/document filters, and retrieves candidates.
6. Retrieval blends vector, lexical, and metadata signals, then reranks results.
7. Answer service assembles a grounded response and returns citations, evidence metadata, and confidence signals.

Note: FAISS is installed and available in the codebase, while the primary retrieval path currently scores DB-stored embeddings directly.

## How retrieval-augmented generation works in this project
- Query text is optionally rewritten for clarity, then embedded.
- Retrieval searches indexed chunks and combines:
  - vector similarity scores,
  - lexical overlap scores,
  - metadata overlap signals.
- Candidates are reranked before final citation selection.
- The answer service either:
  - returns an evidence-based heuristic response with source-linked citations, or
  - returns a low-evidence fallback when retrieval confidence is weak.

> Current default behavior is grounded heuristic generation (no external hosted LLM call in the main flow). This keeps development reproducible and avoids API-key dependencies for local setup.

## Setup and installation instructions
### Local setup
```bash
make bootstrap
make init
make run-backend
make run-frontend
```

Open:
- Frontend: `http://localhost:5173`
- API docs: `http://localhost:8000/docs`

### Docker setup
```bash
make dev
```

### Demo credentials
- `admin@calisto.ai` / `password123`
- `member@calisto.ai` / `password123`
- `viewer@calisto.ai` / `password123`

### Validation and utility commands
```bash
make lint
make test
make smoke-test
python scripts/evaluate_retrieval.py
```

## Example use cases
- **AI Engineering:** Build and iterate on modular RAG services (ingestion, retrieval, reranking, grounded answering).
- **Data Science / IR:** Evaluate chunking strategies and hybrid semantic-keyword retrieval behavior.
- **Enterprise Search:** Provide citation-backed answers for internal policy and operational knowledge.
- **API/Platform Engineering:** Extend authenticated, role-aware knowledge APIs and analytics endpoints.

## What I learned / skills demonstrated
- Built an end-to-end RAG pipeline: ingestion, chunking, embeddings, retrieval, reranking, and grounded response assembly.
- Implemented semantic search patterns and relevance scoring using Python service layers.
- Designed for explainability with source traceability, citation coverage, and confidence outputs.
- Developed role-aware, organization-scoped APIs for enterprise knowledge access.
- Integrated backend services with a React frontend for document operations, chat, and analytics workflows.

## Resume-ready project description
Engineered a full-stack **Enterprise RAG Knowledge Assistant** using **Python (FastAPI), SQLAlchemy, and React** to ingest unstructured enterprise documents, generate embeddings, execute hybrid semantic/lexical retrieval with reranking, and deliver citation-grounded answers through authenticated APIs and UI workflows. Implemented ingestion pipelines, role-based access controls, organization-scoped retrieval, and evaluation scripts to support practical enterprise knowledge management.

## Future improvements
- Replace deterministic embeddings with production-grade embedding providers.
- Add provider-backed LLM generation options while preserving citation-grounded output contracts.
- Move vector retrieval to a persistent/scalable vector backend for larger corpora.
- Expand offline evaluation datasets and metrics reporting for retrieval quality.
- Add deeper operational observability for ingestion/retrieval latency and error patterns.
