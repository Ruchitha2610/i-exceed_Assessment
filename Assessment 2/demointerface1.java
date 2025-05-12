interface BasicAppliance {
    public void turnOn();
}

interface SmartAppliance extends BasicAppliance {
    public void connectToWifi(); 
}

class SmartWashingMachine implements SmartAppliance {
    @Override
    public void turnOn() {
        System.out.println("Washing machine is now ON.");
    }

    @Override
    public void connectToWifi() {
        System.out.println("Washing machine connected to Wi-Fi.");
    }
}

public class demointerface1 {
    public static void main(String[] args) {
        SmartWashingMachine washer = new SmartWashingMachine();
        washer.turnOn();
        washer.connectToWifi();
    }
}
