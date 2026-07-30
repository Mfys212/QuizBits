from sqlalchemy import Column, Integer, String, Enum
from sqlalchemy.orm import relationship
from app.core.database import Base

class Category(Base):
    __tablename__ = "categories"

    id = Column(Integer, primary_key=True, index=True)
    kategori = Column(String(100), nullable=False)

    def __repr__(self):
        return f"<Category {self.kategori}>"