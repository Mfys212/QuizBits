from sqlalchemy import Column, Integer, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from app.core.database import Base
from datetime import datetime, timezone

class Rating(Base):
    __tablename__ = "ratings"

    id = Column(Integer, primary_key=True, index=True)
    rating = Column(Integer, nullable=False)
    created_at = Column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        nullable=False
    )
    question_id = Column(
        Integer,
        ForeignKey("questions.id"),
        nullable=False
    )
    user_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=False
    )
    question = relationship("Question", back_populates="ratings")
    user = relationship("User", back_populates="ratings")

    def __repr__(self):
        return f"<Reward {self.reward}, User {self.user}>"