# Melakukan import mysql connector
import mysql.connector

# Melakukan percobaan koneksi
conn = mysql.connector.connect(
    user='root', password='mysqlpassword', host='localhost', database='kalbe')

# Membuat object cursor sebagai penanda
cursor = conn.cursor()

# Deklarasi SQL Query untuk memasukan record ke DB (KARYAWAN)
Insert_sql = (
    "INSERT INTO KARYAWAN (FIRST_NAME, LAST_NAME, AGE, SEX, INCOME)"
    "VALUES (%s, %s, %s, %s, %s)"
)
values = ('Khafie', 'Ramadhan', '30', 'M', 1000000)
try:
    # eksekusi SQL Command
    cursor.execute(Insert_sql, values)

    # Melakukan perubahan (commit) pada DB
    conn.commit()

except:
    conn.rollback()

# Menutup Koneksi
conn.close()
