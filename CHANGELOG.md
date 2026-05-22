# Changelog

All notable changes to this project are documented in this file.

## [1.0.0] - 2026-05-22
### Added
- Full-stack baseline platform with a React (Vite) frontend and FastAPI backend for enterprise-style RAG workflows.
- Authentication flows with role-oriented UX paths for admin/member/viewer usage patterns.
- Document ingestion pipeline including upload, parsing, chunking, and indexing paths.
- Hybrid retrieval stack combining lexical search and vector similarity with weighted reranking.
- Citation-grounded answer assembly for transparent response generation.
- Admin and audit surfaces for observability and operational review.
- Local-first sample dataset under `data/samples/` for demo and evaluation scenarios.
- Developer tooling: Docker Compose workflows, Make targets, backend tests, linting, and CI automation.

### Notes
- Default behavior is intentionally demo-safe and local-first: deterministic/hash-based embeddings and heuristic answer synthesis can run without paid external model APIs.
