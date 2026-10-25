
# Shop Inventory Manager
# Beginner Python Portfolio Project

products = {
    "Rice": 10,
    "Sugar": 4,
    "Cooking Oil": 2,
    "Beans": 8,
    "Flour": 3
}

print("SHOP INVENTORY REPORT")
print("---------------------")

for product, quantity in products.items():
    print(f"{product}: {quantity} units")

print("\nSTOCK STATUS")
print("------------")

for product, quantity in products.items():
    if quantity < 5:
        print(f"{product}: Low stock")
    else:
        print(f"{product}: Stock is sufficient")

total_units = sum(products.values())

print("\nTOTAL INVENTORY")
print("----------------")
print(f"Total units in stock: {total_units}")
