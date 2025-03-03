from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from models.database import SessionLocal
from models.sip_trunk import SIPTrunk
from schemas.sip_trunk import SIPTrunkCreate, SIPTrunkRead

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/sip_trunks/", response_model=SIPTrunkRead)
def create_sip_trunk(sip_trunk: SIPTrunkCreate, db: Session = Depends(get_db)):
    existing = db.query(SIPTrunk).filter(SIPTrunk.domain == sip_trunk.domain).first()
    if existing:
        raise HTTPException(status_code=400, detail="SIP Trunk already exists for this domain.")
    new_sip_trunk = SIPTrunk(**sip_trunk.dict())
    db.add(new_sip_trunk)
    db.commit()
    db.refresh(new_sip_trunk)
    return new_sip_trunk

@router.get("/sip_trunks/{tenant_id}/", response_model=list[SIPTrunkRead])
def get_sip_trunks_by_tenant(tenant_id: int, db: Session = Depends(get_db)):
    sip_trunks = db.query(SIPTrunk).filter(SIPTrunk.tenant_id == tenant_id).all()
    if not sip_trunks:
        raise HTTPException(status_code=404, detail="No SIP Trunks found for this tenant.")
    return sip_trunks
