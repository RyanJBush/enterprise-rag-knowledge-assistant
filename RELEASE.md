# Release Notes

## v1.0.0 — May 2026

Initial production-ready portfolio release of the Enterprise RAG Knowledge Platform (Callisto), including:

- Full-stack architecture with React frontend and FastAPI backend.
- Document ingestion, chunking, and indexing pipeline.
- Hybrid retrieval (lexical + vector) with weighted reranking.
- Citation-aware answer assembly and chat experience.
- Admin/audit and operational observability surfaces.
- Local sample datasets and evaluation script support.
- Developer tooling: Docker Compose, Make targets, linting, tests, and CI workflow.

---

## Tagging instructions

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```
