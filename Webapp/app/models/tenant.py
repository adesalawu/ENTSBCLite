from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from .database import Base

class Tenant(Base):
    __tablename__ = "tenants"
    id = Column(Integer, primary_key=True, index=True)
    domain = Column(String, unique=True, index=True)
    admin_email = Column(String, unique=True, index=True)
    sip_trunk_provider = Column(String)

    # Relationship with SIPTrunk
    sip_trunks = relationship("SIPTrunk", back_populates="tenant", cascade="all, delete-orphan")
