from sqlalchemy import Column, Integer, DateTime, ForeignKey, Text
from sqlalchemy.orm import relationship
from app.core.database import Base
from datetime import datetime, timezone

class MessageDetail(Base):
    __tablename__ = "message_detail"

    id = Column(Integer, primary_key=True, index=True)
    text = Column(Text, nullable=False)
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
    message_id = Column(
        Integer,
        ForeignKey("messages.id"),
        nullable=False
    )

    message = relationship("Message", back_populates="message_detail")
    user = relationship("User", back_populates="message_detail")

    def __repr__(self):
        return f"<Messages {self.user}>"

    
