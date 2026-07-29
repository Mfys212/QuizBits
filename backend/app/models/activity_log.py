from sqlalchemy import Column, Integer, String, DateTime, Text
from datetime import datetime, timezone
from app.core.database import Base

class ActivityLog(Base):
    __tablename__ = "activity_logs"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, nullable=True)   # siapa yang melakukan
    module = Column(String(50), nullable=False)    # misal: "comment", "question"
    action = Column(String(50), nullable=False)    # "create", "update", "delete"
    object_id = Column(Integer, nullable=False) # id objek yang diubah
    description = Column(Text, nullable=False) # detail perubahan
    created_at = Column(
        DateTime(timezone=True),
        default=lambda: datetime.now(timezone.utc),
        nullable=False
    )

    def __repr__(self):
        return f"<Log {self.id}>"