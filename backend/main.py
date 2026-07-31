from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.database import Base, engine
from app.api import auth, users, categories, questions, comments, ratings, rewards, messages

# Uncomment untuk auto create table di dev, prod pakai alembic
# Base.metadata.create_all(bind=engine)

app = FastAPI(title="QuizBits API", version="1.0.0", description="Backend untuk QuizBits - Flutter Quiz App")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(users.router)
app.include_router(categories.router)
app.include_router(questions.router)
app.include_router(comments.router)
app.include_router(ratings.router)
app.include_router(rewards.router)
app.include_router(messages.router)

@app.get("/")
def root():
    return {"message": "QuizBits API jalan bro!", "docs": "/docs"}

@app.get("/health")
def health():
    return {"status": "ok"}
