from sqlalchemy import Column, Integer, String,  DateTime, Text, ForeignKey
from sqlalchemy.orm import relationship
from app.core.database import Base
from datetime import datetime, timezone

class Reward(Base):
    __tablename__ = "rewards"

    id = Column(Integer, primary_key=True, index=True)
    reward = Column(Integer, nullable=False)
    user_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=False
    )

    user = relationship("User", back_populates="rewards")

    def __repr__(self):
        return f"<Reward {self.reward}, User {self.user}>"

    
