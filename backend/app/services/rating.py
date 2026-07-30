from sqlalchemy.orm import Session
from fastapi import HTTPException
from app.models.rating import Rating
from app.schemas.rating import RatingCreate

def create_or_update_rating(db: Session, data: RatingCreate, user_id: int):
    existing = db.query(Rating).filter(Rating.question_id==data.question_id, Rating.user_id==user_id).first()
    if existing:
        existing.rating = data.rating
        db.commit()
        db.refresh(existing)
        return existing
    r = Rating(rating=data.rating, question_id=data.question_id, user_id=user_id)
    db.add(r)
    db.commit()
    db.refresh(r)
    return r

def get_ratings_by_question(db: Session, question_id: int):
    return db.query(Rating).filter(Rating.question_id==question_id).all()

def get_avg_rating(db: Session, question_id: int):
    ratings = db.query(Rating).filter(Rating.question_id==question_id).all()
    if not ratings:
        return 0
    return sum(r.rating for r in ratings)/len(ratings)
