from pydantic import BaseModel, Field
from datetime import datetime

class RewardBase(BaseModel):
    reward: int = Field(
        ..., 
        description="Jumlah poin reward", 
        example=10
    )

class RewardCreate(RewardBase):
    user_id: int = Field(
        ..., 
        description="ID user penerima reward", 
        example=1
    )

class RewardRead(RewardBase):
    id: int = Field(
        ..., 
        description="ID unik reward"
    )
    user_id: int = Field(
        ..., 
        description="ID user pemilik reward"
    )
    created_at: datetime = Field(
        ..., 
        description="Waktu reward diberikan"
    )
    model_config = {"from_attributes": True}
