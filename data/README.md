# Data Directory Guide

This folder stores local sample documents used to test ingestion, retrieval, and answer quality during development.

## What to place here
- Policy and handbook style text files.
- Internal runbooks and operational documents.
- Evaluation fixtures for known Q&A pairs.

A starter sample set is already included in `data/samples/`.

## Supported formats
For local testing, place documents in one of these formats:
- `.txt` (recommended for fast iteration)
- `.md`
- `.json` (structured fixtures/eval sets)
- `.pdf` (if PDF extraction is enabled in your runtime dependencies)

## Quick sample data workflow
Use the included samples immediately:

```bash
ls data/samples
```

Then run the app and upload any sample document from `data/samples/` via the Documents page.

## Script reference
To run retrieval quality checks against the bundled sample evaluation set:

```bash
python scripts/evaluate_retrieval.py
```

This script uses the local API and sample fixtures to validate retrieval behavior during development.
