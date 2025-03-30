# Bitwise Shift Operations (`<<`, `>>`)

## 1️⃣ Left Shift (`<<`) → Multiplies by 2
- **Shifting bits left (`n << k`) moves each bit `k` positions left**, filling the rightmost bits with `0s`.
- This **effectively multiplies the number by `2^k`** in binary.

### Example (Left Shift by 1)
#### Binary Representation of 5 (`00000101` in 8-bit)
```
5  =  00000101  (Binary)
5 << 1 = 00001010  (Binary)  → 10 (Decimal)
5 << 2 = 00010100  (Binary)  → 20 (Decimal)
```
- **Shift left by 1 (`<< 1`) → 5 × 2 = 10**
- **Shift left by 2 (`<< 2`) → 5 × 4 = 20**

👉 **Why?**  
Each left shift **doubles the value** because the binary system is base 2. When a bit shifts left, it moves to a place representing **twice the previous value**.

---

## 2️⃣ Right Shift (`>>`) → Divides by 2
- **Shifting bits right (`n >> k`) moves each bit `k` positions right**, filling the leftmost bits with `0s` (for unsigned numbers).
- This **effectively divides the number by `2^k`** in binary.

### Example (Right Shift by 1)
#### Binary Representation of 20 (`00010100` in 8-bit)
```
20  = 00010100  (Binary)
20 >> 1 = 00001010  (Binary)  → 10 (Decimal)
20 >> 2 = 00000101  (Binary)  → 5  (Decimal)
```
- **Shift right by 1 (`>> 1`) → 20 ÷ 2 = 10**
- **Shift right by 2 (`>> 2`) → 20 ÷ 4 = 5**

👉 **Why?**  
Each right shift **halves the value** because in binary, shifting a bit to the right reduces its weight (powers of 2).

---

## 3️⃣ Signed vs. Unsigned Right Shift
- **Unsigned Right Shift (`>>>` in Java, JavaScript)** → Always fills left bits with `0s`.
- **Signed Right Shift (`>>`)**:
  - **For positive numbers**, it behaves normally.
  - **For negative numbers (in Two’s Complement)**, the sign bit (leftmost bit) may be preserved.

### Example of Signed Right Shift (`>>`)
```
-8 (in 8-bit Two's Complement) = 11111000  
-8 >> 1  =  11111100  (Binary)  → -4 (Decimal)
```
👉 **Why?** Preserving the sign bit maintains the negative value.

---

## 4️⃣ When Are Bitwise Shifts Used?
✅ **Fast Multiplication/Division** → Used in low-level optimizations.  
✅ **Bitmasking & Flag Operations** → Setting/clearing bits efficiently.  
✅ **Cryptography & Compression** → Manipulating binary data structures.  

---

## 🔹 Summary
| **Operation** | **Effect** | **Example (5)** | **Why?** |
|--------------|-----------|-----------------|----------|
| `x << 1`  | Multiply by 2  | `5 << 1 = 10`  | Each bit moves left, doubling value. |
| `x << k`  | Multiply by `2^k` | `5 << 2 = 20` | Shift left `k` times → `5 × 2^2 = 20` |
| `x >> 1`  | Divide by 2  | `20 >> 1 = 10` | Each bit moves right, halving value. |
| `x >> k`  | Divide by `2^k` | `20 >> 2 = 5` | Shift right `k` times → `20 ÷ 2^2 = 5` |

🔹 **Bitwise shifts provide an efficient way to perform power-of-2 multiplications and divisions!** 🚀

