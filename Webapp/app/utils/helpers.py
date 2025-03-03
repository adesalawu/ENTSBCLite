import jwt
from datetime import datetime, timedelta
from fastapi import HTTPException, status
from pydantic import EmailStr
from passlib.context import CryptContext
from dotenv import dotenv_values
from typing import Any, Dict

# Load environment variables
config = dotenv_values(".env")

# Password hashing context
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# JWT Secret and Algorithm
SECRET_KEY = config.get("SECRET_KEY", "default_secret_key")
ALGORITHM = "HS256"

def hash_password(password: str) -> str:
    """Hash a plain password."""
    return pwd_context.hash(password)

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verify a plain password against a hashed password."""
    return pwd_context.verify(plain_password, hashed_password)

def create_access_token(data: dict, expires_delta: timedelta = None) -> str:
    """Create a JWT access token."""
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=15))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

def decode_access_token(token: str) -> Dict[str, Any]:
    """Decode a JWT token."""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Token has expired")
    except jwt.PyJWTError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")

def is_valid_email(email: EmailStr) -> bool:
    """Validate an email address."""
    return True if email else False

def format_response(success: bool, message: str, data: Any = None) -> Dict[str, Any]:
    """Format a standard API response."""
    return {"success": success, "message": message, "data": data}
