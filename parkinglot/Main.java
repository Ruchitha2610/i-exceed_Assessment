import java.util.*;

class Vehicle {
    String type, regNumber, color;

    Vehicle(String type, String regNumber, String color) {  //initializing
        this.type = type;
        this.regNumber = regNumber;
        this.color = color;
    }
}

class Slot {
    int floor, number;
    String type;
    Vehicle parkedVehicle;//tells the info about the parked vehicle

    Slot(int floor, int number, String type) {  //initializing
        this.floor = floor;
        this.number = number;
        this.type = type;
        this.parkedVehicle = null;
    }

    boolean isAvailable() {  //checks whether slot is empty or not
        return parkedVehicle == null; //if empty returns null
    }

    String getSlotId() {  //after parking vehicle get slot id for ticket
        return "PR123_" + floor + "_" + number;
    }
}

class ParkingLot {
    int floors = 5;
    int slotsPerFloor = 15;
    Map<String, Slot> ticketMap = new HashMap<>();//to store the ticket
    List<List<Slot>> slots;//to get the slots at particular floor

    public ParkingLot() {  //initializing
        slots = new ArrayList<>();

        for (int f = 0; f < floors; f++) {
            List<Slot> floorSlots = new ArrayList<>();
            for (int s = 0; s < slotsPerFloor; s++) {
                String type;
				//if else is used to mark the type of vehicle to be parked in each slot
                if (s < 3) type = "truck";       // slots 1-3   
                else if (s < 6) type = "bike";    // slots 4-6
                else type = "car";                // slots 7-15
                floorSlots.add(new Slot(f + 1, s + 1, type));
            }
            slots.add(floorSlots);
        }
    }

    public String parkVehicle(Vehicle vehicle) {  //parking the vehicle and returns ticket
        for (List<Slot> floorSlots : slots) {   //iterate through floors
            for (Slot slot : floorSlots) {   //iterate through the slots in each floor
                if (slot.type.equals(vehicle.type) && slot.isAvailable()) {
                    slot.parkedVehicle = vehicle;
                    String ticket = slot.getSlotId();//ticket is generated
                    ticketMap.put(ticket, slot);//to store ticket that is used during unparking
                    return ticket;//ticket is returned and parking is confirmed
                }
            }
        }
        return "No available slot for vehicle type: " + vehicle.type;
    }

    public boolean unparkVehicle(String ticket, int hoursParked) {
    if (ticketMap.containsKey(ticket)) {//checks if ticket is available in ticketmap
        Slot slot = ticketMap.get(ticket);//value slot is retrived
        String type = slot.parkedVehicle.type;//get the vehicle type parked in that slot number
        int rate = 0;//parking amt per hour

        switch (type) { //based on vehicle type rate is fixed
            case "car": rate = 50; break;
            case "bike": rate = 25; break;
            case "truck": rate = 100; break;
        }

        int amount = hoursParked * rate;
        System.out.println("Vehicle Type: " + type);
        System.out.println("Hours Parked: " + hoursParked);
        System.out.println("Total Amount: ₹" + amount);

        slot.parkedVehicle = null;//slot is emptied
        ticketMap.remove(ticket);//removed from ticketmap
        return true;
    }
    return false;//ticket is invaid
}


    public void displayAvailableSlots(String vehicleType) {//display  which slots are available
        System.out.println("Available slots for " + vehicleType + ":");
        for (List<Slot> floorSlots : slots) {
            for (Slot slot : floorSlots) {
                if (slot.type.equals(vehicleType) && slot.isAvailable()) {
                    System.out.print(slot.floor + "_" + slot.number + " ");//prints the available slots with floors
                }
            }
            System.out.println();
        }
    }

    public void displayOccupiedSlots(String vehicleType) {//occupied slots of vehicle type are displayed
    boolean anyOccupied = false;//to check any occupied slot was present. initially set to false 
    System.out.println("Occupied slots for " + vehicleType + ":");
    for (List<Slot> floorSlots : slots) {//iterates through each floor
        boolean floorPrinted = false;//checks for occupied in any floors, if there set to true otherwise checks for other floor
        for (Slot slot : floorSlots) {//iterates through each slot
            if (slot.type.equals(vehicleType) && !slot.isAvailable()) {  //condition is true
                System.out.print(slot.floor + "_" + slot.number + " ");
                anyOccupied = true;//occupied
                floorPrinted = true;
            }
        }
        if (floorPrinted) System.out.println();//occupied
    }
    if (!anyOccupied) {//if anyoccupied is false
        System.out.println("All slots for " + vehicleType + " are free.");
    }
}


    public int getAvailableSlotCount(String vehicleType) {//gives the count of available slots
        int count = 0;
        for (List<Slot> floorSlots : slots) {
            for (Slot slot : floorSlots) {
                if (slot.type.equals(vehicleType) && slot.isAvailable()) {
                    count++;
                }
            }
        }
        return count;
    }
}

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ParkingLot lot = new ParkingLot();

        while (true) {
            System.out.println("\n--- Parking Lot Menu ---");
            System.out.println("1. Park Vehicle");
            System.out.println("2. Unpark Vehicle");
            System.out.println("3. Display Available Slots");
            System.out.println("4. Display Occupied Slots");
            System.out.println("5. Exit");
            System.out.print("Choose an option: ");
            int option = scanner.nextInt();
            scanner.nextLine(); //consume the leftover newline character

            switch (option) {
                case 1:
                    System.out.print("Enter vehicle type (car/bike/truck): ");
                    String type = scanner.nextLine().toLowerCase();//lower case coversion because it becomes easier to compare the strings
                    System.out.print("Enter registration number: ");
                    String regNo = scanner.nextLine();
                    System.out.print("Enter color: ");
                    String color = scanner.nextLine();

                    Vehicle vehicle = new Vehicle(type, regNo, color);//vehicle object is created
                    String ticket = lot.parkVehicle(vehicle);//parkvehicle function is called
                    System.out.println("Ticket: " + ticket);
                    break;

                case 2:
                    System.out.print("Enter ticket to unpark (e.g., PR123_2_4): ");
                    String ticketId = scanner.nextLine();//to read the entire line of input from the user
                    System.out.print("Enter number of hours parked: ");
                    int hours = scanner.nextInt();
                    scanner.nextLine(); 

                    if (lot.unparkVehicle(ticketId, hours)) {
                        System.out.println("Vehicle unparked successfully.");
                    } else {
                        System.out.println("Invalid ticket.");
                    }
					break;


                case 3:
                    System.out.print("Enter vehicle type to check availability: ");
                    String availableType = scanner.nextLine();//vehicle type
                    int availableCount = lot.getAvailableSlotCount(availableType);//get the count of available slots
                    System.out.println("Available slots: " + availableCount);
                    lot.displayAvailableSlots(availableType);//which slots are free
                    break;

                case 4:
                    System.out.print("Enter vehicle type to check occupied slots: ");
                    String occupiedType = scanner.nextLine();
                    lot.displayOccupiedSlots(occupiedType);//which slots are occupied
                    break;

                case 5:
                    System.out.println("Exiting...");
                    scanner.close();
                    return;

                default:
                    System.out.println("Invalid option. Try again.");
            }
        }
    }
}