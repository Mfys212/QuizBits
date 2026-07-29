from sqlalchemy import Column, Integer, String,  DateTime, Text, ForeignKey
from sqlalchemy.orm import relationship
from app.core.database import Base
from datetime import datetime, timezone

class Question(Base):
    __tablename__ = "questions"

    id = Column(Integer, primary_key=True, index=True)
    question = Column(Text, nullable=False)
    correct_answer = Column(Text, nullable=False)
    explanation = Column(Text, nullable=False)
    views = Column(Integer, default=0)
    answerer = Column(Integer, default=0)
    cover_url = Column(String(255), nullable=False)
    created_at = Column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        nullable=False
    )
    user_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=False
    )

    user = relationship("User", back_populates="questions")
    views_logs = relationship(
        "QuestionView",
        cascade="all, delete-orphan",
        passive_deletes=True
    )
    answers = relationship(
        "Answer",
        back_populates="question",
        cascade="all, delete-orphan"
    )
    comments = relationship(
        "Comment",
        back_populates="question",
        cascade="all, delete-orphan"
    )
    ratings = relationship(
        "Rating",
        back_populates="question",
        cascade="all, delete-orphan"
    )

    def __repr__(self):
        return f"<Question {self.question}>"

    
