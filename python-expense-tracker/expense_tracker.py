#PROJECT
#Menu loop
expenses=[]

while True:
  print("\n1. Add an expense")
  print("2. View all expenses")
  print("3. View total category")
  print("4. Quit")
  choice=input("Choose an option")

  if choice =="1":
    print("Add an expense")

    description=input("Enter expense description:")
    category=input("Enter expense category:")
    amount=float(input("Enter expense amount:"))


    expense = {
    "description": description,
    "category": category,
    "amount": amount
   }
    expenses.append(expense)
    print("Expense added successfully")
  
  elif choice=="2":
    print("View all expenses")

    if not expenses:
      print("No expenses found")
    else:
        for expense in expenses:
         print(f"Description:{expense['description']}")
         print(f"Category:{expense['category']}")
         print(f"Amount:{expense['amount']}")

    

  elif choice=="3":
      print("View total category")

      if not expenses:
       print("No expenses to calculate")
      else:

       totals={}
      for expense in expenses:
        category=expense["category"]
        amount=expense["amount"]

        if category in totals:
            totals[category] += amount

        else:
            totals[category] = amount

      for category, total in totals.items():
        print(f"{category}: {total}")





  elif choice=="4":
    print("Goodbye!")
    break

  else:
    print("Invalid choice. Please try again.")

  

    
