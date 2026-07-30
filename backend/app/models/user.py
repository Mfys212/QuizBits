from sqlalchemy import Column, Integer, String, Enum
from sqlalchemy.orm import relationship
from app.core.database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(255), unique=True, nullable=False, index=True)
    username = Column(String(255), unique=True, nullable=False)
    password = Column(String(255), nullable=False)
    role = Column(
        Enum("developer", "admin", "user", name="user_roles"),
        nullable=False,
        default="user"
    )
    questions = relationship(
        "Question",
        back_populates="user",
        cascade="all, delete-orphan"
    )
    rewards = relationship(
        "Reward",
        back_populates="user",
        cascade="all, delete-orphan"
    )
    comments = relationship(
        "Comment",
        back_populates="user",
        cascade="all, delete-orphan"
    )
    message_details = relationship(
        "MessageDetail", 
        back_populates="user", 
        cascade="all, delete-orphan"
    )
    ratings = relationship(
        "Rating",
        back_populates="user",
        cascade="all, delete-orphan"
    )
    activity_logs = relationship(
        "ActivityLog", 
        back_populates="user"
    )

    def __repr__(self):
        return f"<User id={self.id} email={self.email} role={self.role}>"