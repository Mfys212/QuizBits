from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.core.dependencies import get_current_user
from app.models.user import User
from app.services.reward import get_rewards_by_user, get_total_reward

router = APIRouter(prefix="/rewards", tags=["rewards"])

@router.get("/me")
def my_rewards(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    rewards = get_rewards_by_user(db, current_user.id)
    total = get_total_reward(db, current_user.id)
    return {"total": total, "rewards": rewards}
