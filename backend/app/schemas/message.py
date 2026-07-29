from pydantic import BaseModel, Field
from datetime import datetime
from typing import List
from message_detail import MessageDetailRead

class MessageBase(BaseModel):
    pass

class MessageCreate(MessageBase):
    pass

class MessageUpdate(BaseModel):
    pass

class MessageRead(MessageBase):
    id: int = Field(
        ...,
        description="ID Percakapan"
    )
    created_at: datetime = Field(
        ...,
        description="Waktu Percakapan Dibuat"
    )
    user: str = Field(
        ...,
        description="Lawan Percakapan User"
    )
    messages: List[MessageDetailRead] = []
    model_config = {
        "from_attributes": True
    }
