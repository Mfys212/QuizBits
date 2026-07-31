from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.core.dependencies import get_current_user
from app.models.message import Message
from app.models.message_detail import MessageDetail
from app.schemas.message import MessageCreate, MessageRead
from app.schemas.message_detail import MessageDetailCreate, MessageDetailRead
from app.models.user import User

router = APIRouter(prefix="/messages", tags=["messages"])

@router.post("/", response_model=MessageRead)
def create_conversation(data: MessageCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if data.user2_id == current_user.id:
        raise HTTPException(status_code=400, detail="Tidak bisa chat dengan diri sendiri")
    existing = db.query(Message).filter(((Message.user1_id==current_user.id) & (Message.user2_id==data.user2_id)) | ((Message.user1_id==data.user2_id) & (Message.user2_id==current_user.id))).first()
    if existing:
        return existing
    msg = Message(user1_id=current_user.id, user2_id=data.user2_id)
    db.add(msg)
    db.commit()
    db.refresh(msg)
    return msg

@router.get("/", response_model=list[MessageRead])
def list_my_conversations(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(Message).filter((Message.user1_id==current_user.id) | (Message.user2_id==current_user.id)).all()

@router.post("/detail", response_model=MessageDetailRead)
def send_message(data: MessageDetailCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    conv = db.query(Message).filter(Message.id==data.message_id).first()
    if not conv:
        raise HTTPException(status_code=404, detail="Conversation tidak ditemukan")
    if current_user.id not in [conv.user1_id, conv.user2_id]:
        raise HTTPException(status_code=403, detail="Bukan participant")
    detail = MessageDetail(text=data.text, user_id=current_user.id, message_id=data.message_id)
    db.add(detail)
    db.commit()
    db.refresh(detail)
    return detail

@router.get("/{message_id}/details", response_model=list[MessageDetailRead])
def get_details(message_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    conv = db.query(Message).filter(Message.id==message_id).first()
    if not conv:
        raise HTTPException(status_code=404, detail="Conversation tidak ditemukan")
    if current_user.id not in [conv.user1_id, conv.user2_id]:
        raise HTTPException(status_code=403, detail="Bukan participant")
    return db.query(MessageDetail).filter(MessageDetail.message_id==message_id).order_by(MessageDetail.created_at).all()
