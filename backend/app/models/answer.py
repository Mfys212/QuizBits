from sqlalchemy import Column, Integer, Text, ForeignKey
from sqlalchemy.orm import relationship
from app.core.database import Base

class Answer(Base):
    __tablename__ = "answers"

    id = Column(Integer, primary_key=True, index=True)
    answer = Column(Text, nullable=False)
    question_id = Column(
        Integer,
        ForeignKey("questions.id"),
        nullable=False
    )

    question = relationship("Question", back_populates="answers")

    def __repr__(self):
        return f"<Answer {self.answer}>"