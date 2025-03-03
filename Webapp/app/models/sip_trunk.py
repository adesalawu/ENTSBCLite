from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .database import Base

class SIPTrunk(Base):
    __tablename__ = "sip_trunks"
    id = Column(Integer, primary_key=True, index=True)
    provider_name = Column(String, nullable=False)
    domain = Column(String, nullable=False)
    tenant_id = Column(Integer, ForeignKey("tenants.id"), nullable=False)

    # Relationship with Tenant
    tenant = relationship("Tenant", back_populates="sip_trunks")

    credentials = Column(String, nullable=False)  # Encrypted credentials for authentication
    region = Column(String, nullable=True)  # Optional region information
    max_channels = Column(Integer, nullable=True)  # Maximum concurrent call channels
