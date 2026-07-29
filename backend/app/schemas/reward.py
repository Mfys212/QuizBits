from pydantic import BaseModel, Field
from typing import Optional

class RewardBase(BaseModel):
    reward: int = Field(
        ...,
        description="Jumlah Reward"
    )

class RewardCreate(RewardBase):
    pass

class RewardUpdate(BaseModel):
    reward: Optional[str] = Field(
        None,
        description="Jumlah Reward (jika kosong tidak diubah)"
    )

class RewardRead(RewardBase):
    id: int = Field(
        ...,
        description="ID Reward"
    )
    model_config = {
        "from_attributes": True
    }
