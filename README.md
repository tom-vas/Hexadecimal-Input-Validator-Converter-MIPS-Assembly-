# Hexadecimal Input Validator & Converter (MIPS Assembly)

This project implements a MIPS assembly program that:

1. **Reads four hexadecimal characters** from user input
2. **Validates** each character (`0–9` and `A–F`)
3. **Packs** the bytes into a 32-bit value
4. **Converts** the packed hexadecimal number into its decimal representation
5. **Prints** the result or an **error message** if the input is invalid

---

## 📌 Features

* Input validation for uppercase hex characters
* Byte packing using bitwise operations
* Manual hexadecimal-to-decimal conversion using powers of 16
* Clear error handling and output formatting

---

## 🧠 How It Works

### **1. Input & Validation**

The program reads one character at a time using syscall `12`.
It checks whether each character is within:

* `'0'` to `'9'`, or
* `'A'` to `'F'`

Invalid input triggers an error exit path.

Characters are packed into a register by shifting left 8 bits and OR-ing
with the new byte.

---

### **2. Decimal Conversion**

Once all 4 bytes are collected:

* The least significant byte is extracted with a mask (`0xFF`)
* Letters (`A–F`) are mapped to values (`10–15`)
* The program multiplies by the appropriate power of 16
* Accumulates into the final decimal value

---

### **3. Output**

* Prints the decimal result
* Or prints:

  ```
  Wrong Hex Number ...
  ```

---

## 🛠 Requirements

* MARS or QtSpim MIPS simulator
* Ability to enter characters one by one (syscall 12)

---

## ▶️ How to Run

1. Open the file in **MARS** or **QtSpim**
2. Assemble the program
3. Run it
4. Enter exactly **4 hexadecimal characters**, e.g.:

```
1A3F
```

5. Get the decimal output.

---

## 📄 Author

* **MIPS code:** Thomas Vasilas ([p3200012@aueb.gr](mailto:p3200012@aueb.gr))

