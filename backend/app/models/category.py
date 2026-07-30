from sqlalchemy import Column, Integer, String, Enum
from sqlalchemy.orm import relationship
from app.core.database import Base

class Category(Base):
    __tablename__ = "categories"

    id = Column(Integer, primary_key=True, index=True)
    kategori = Column(String(100), unique=True, nullable=False)
    questions = relationship("Question", back_populates="category")

    def __repr__(self):
        return f"<Category {self.kategori}>"