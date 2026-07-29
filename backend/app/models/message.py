from sqlalchemy import Column, Integer, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from app.core.database import Base
from datetime import datetime, timezone

class Message(Base):
    __tablename__ = "messages"

    id = Column(Integer, primary_key=True, index=True)
    created_at = Column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        nullable=False
    )
    user1_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=False
    )
    user2_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=False
    )

    user1 = relationship(
        "User",
        foreign_keys=[user1_id],
        back_populates="messages",
    )

    user2 = relationship(
        "User",
        foreign_keys=[user2_id],
        back_populates="messages",
    )

    message_detail = relationship(
        "MessageDetail",
        back_populates="messages",
        cascade="all, delete-orphan"
    )

    def __repr__(self):
        return f"<Messages {self.user}>"