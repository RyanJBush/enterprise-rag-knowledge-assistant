.PHONY: bootstrap init db-upgrade db-downgrade lint test run-backend run-frontend
.PHONY: bootstrap init lint test run-backend run-frontend

bootstrap:
	python -m pip install --upgrade pip
	pip install -r backend/requirements.txt
	npm --prefix frontend install

init:
	cd backend && PYTHONPATH=. python scripts/init_db.py

db-upgrade:
	cd backend && PYTHONPATH=. alembic upgrade head

db-downgrade:
	cd backend && PYTHONPATH=. alembic downgrade -1

lint:
	ruff check backend
	npm --prefix frontend run lint

test:
	cd backend && rm -f test.db && DATABASE_URL=sqlite:///./test.db pytest tests
	npm --prefix frontend run build

run-backend:
	cd backend && uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

run-frontend:
	npm --prefix frontend run dev -- --host 0.0.0.0 --port 5173


dev:
	docker compose up --build

smoke-test:
	python scripts/smoke_test.py


.PHONY: demo

demo:
	@echo "Quick end-to-end demo"
	@echo "1) Install deps: make bootstrap"
	@echo "2) Start stack: make dev"
	@echo "3) Sign in: admin@calisto.ai / password123"
	@echo "4) Upload sample doc: data/samples/employee_handbook.txt"
	@echo "5) Ask in Chat: What are the PTO rules?"
	@echo "6) Optional eval: python scripts/evaluate_retrieval.py"
