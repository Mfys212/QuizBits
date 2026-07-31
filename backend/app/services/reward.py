from sqlalchemy.orm import Session
from app.models.reward import Reward

def add_reward(db: Session, user_id: int, points: int):
    r = Reward(reward=points, user_id=user_id)
    db.add(r)
    db.commit()
    db.refresh(r)
    return r

def get_rewards_by_user(db: Session, user_id: int):
    return db.query(Reward).filter(Reward.user_id==user_id).all()

def get_total_reward(db: Session, user_id: int):
    rewards = db.query(Reward).filter(Reward.user_id==user_id).all()
    return sum(r.reward for r in rewards)
