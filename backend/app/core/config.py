from dotenv import load_dotenv
import os

load_dotenv()

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "postgres")
DB_NAME = os.getenv("DB_NAME", "quizbits")
DB_SSL_CA = os.getenv("DB_SSL_CA")
SECRET_KEY = os.getenv("SECRET_KEY", "dev-secret-key-ganti-di-production")
JWT_SECRET = os.getenv("JWT_SECRET", SECRET_KEY)

ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", "120"))
DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    DATABASE_URL = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

if not SECRET_KEY:
    raise RuntimeError("SECRET_KEY not set")

UPLOAD_DIR = os.getenv("UPLOAD_DIR", "uploads")
UPLOAD_URL_PREFIX = "/uploads"
MAX_UPLOAD_SIZE = 5 * 1024 * 1024
ALLOWED_IMAGE_TYPES = ["image/jpeg", "image/png", "image/webp", "image/jpg"]
