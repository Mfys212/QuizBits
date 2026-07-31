from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.core.dependencies import get_current_user
from app.schemas.rating import RatingCreate, RatingRead
from app.services.rating import create_or_update_rating, get_ratings_by_question, get_avg_rating
from app.models.user import User

router = APIRouter(prefix="/ratings", tags=["ratings"])

@router.post("/", response_model=RatingRead)
def rate(data: RatingCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return create_or_update_rating(db, data, current_user.id)

@router.get("/question/{question_id}")
def list_ratings(question_id: int, db: Session = Depends(get_db)):
    ratings = get_ratings_by_question(db, question_id)
    avg = get_avg_rating(db, question_id)
    return {"avg_rating": avg, "ratings": ratings}
