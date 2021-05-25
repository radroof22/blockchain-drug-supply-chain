
// “(A) the proprietary or established name or names of the product;
// “(B) the strength and dosage form of the product;
// “(C) the National Drug Code (NDC) number of the product;
// “(D) the container size;
// “(E) the number of containers;
// “(F) the lot number of the product;
// “(G) the date of the transaction;
// “(H) the date of the shipment, if more than 24 hours after the date of the transaction;
// “(I) the business name and address of the person from whom ownership is being transferred; and
// “(J) the business name and address of the person to whom ownership is being transferred.”
pragma solidity >=0.4.21 <0.6.0;
contract CAR_T {
    address chairperson;

    enum State {wait_Manufacturer, Manufacturing, wait_Distributor, Distributing, between_Distributors, wait_Recv, Received, Patient}
    State public state;

    int max_temperature;
    int max_target_temperature;
    int temperature;
    int min_target_temperature;
    int min_temperature;

    bool damaged_product = false;

    bytes public name;
    uint64 public dosage; // (CAR-postitive T Cells)/(kg of body weight)
    uint64 public NDC;
    uint64 public container_size; // infusion bags range from 10ml to 50ml
    uint64 public num_containers;
    uint64 public lot_number;

    uint256 order_timestamp;

    uint256 manufacturing_claimed_timestamp;
    Manufacturer public product_manufacturer;
    uint256 order_manufactured_timestamp;

    Distributor[] public product_distributors;
    uint256 order_start_distribution;
    uint256 order_end_distribution;

    address public product_provider;
    uint256 order_received_timestamp;
    Patient public patient;
    uint256 order_to_patient_timestamp;


    struct Manufacturer {
        bytes32 name;
    }
    mapping(address => Manufacturer) public manufacturers;
    function createManufacturer(address new_manufacturer, bytes32 _name) public{
        // require(
        //     msg.sender == chairperson,
        //     "Only chairperson can create manufacturers"
        // );
        manufacturers[new_manufacturer] = Manufacturer({name: _name});
    }

    struct Distributor {
        bytes32 name;
    }
    mapping(address => Distributor) public distributors;
    function createDistributor(address new_distributor, bytes32 _name) public{
        // require(
        //     msg.sender == chairperson,
        //     "Only chairperson can create distributors"
        // );
        distributors[new_distributor] = Distributor({name: _name});
    }

    struct Hospital{
        bytes32 name;
    }
    mapping(address => Hospital) public hospitals;
    function createHospital(address new_hospital, bytes32 _name) public{
        // require(
        //     msg.sender == chairperson,
        //     "Only chairperson can create hospitals"
        // );
        hospitals[new_hospital] = Hospital({name: _name});
    }

    struct Pharmacy {
        bytes32 name;
    }
    mapping(address => Pharmacy) public pharmacies;
    function createPharmacy(address new_pharmacy, bytes32 _name) public{
        // require(
        //     msg.sender == chairperson,
        //     "Only chairperson can create pharmacies"
        // );
        pharmacies[new_pharmacy] = Pharmacy({name: _name});
    }

    struct Patient{
        bytes32 name;
    }
    mapping(address => Patient) public patients;
    function createPatient(address new_patient, bytes32 _name) public{
        // require(
        //     hospitals[msg.sender].name > 0 || pharmacies[msg.sender].name > 0,
        //     "Only hospitals or pharmacies can create patients."
        // );
        patients[new_patient] = Patient({name: _name});
    }

    constructor(bytes memory _name, uint64 _dosage, uint64 _NDC, uint64 _container_size, uint64 _num_containers) public {
        // require(
        //     hospitals[msg.sender].name > 0 || pharmacies[msg.sender].name > 0,
        //     "Only hospitals or pharmacies can create drug orders."
        // );
        product_provider = msg.sender;
        // create drug order
        name = _name;
        dosage = _dosage;
        NDC = _NDC;
        container_size = _container_size;
        num_containers = _num_containers;
        state = State.wait_Manufacturer;
        order_timestamp = now; //  have to ues it to reference current time
    }

    function startManufacturing() public {
        // require(
        //     manufacturers[msg.sender].name > 0,
        //     "Only approved manufacturers can say a drug has been manufactured"
        // );
        state = State.Manufacturing;
        product_manufacturer = manufacturers[msg.sender];
        manufacturing_claimed_timestamp = now;
    }

    function finishedManufacturing() public {
        // require(
        //     manufacturers[msg.sender].name > 0,
        //     "Only manufacturers can say a drug has been manufactured"
        // );
        state = State.wait_Distributor;
        order_manufactured_timestamp = now;
    }

    function startDistributing(uint64 _lot_number) public {
        // require(
        //     distributors[msg.sender].name > 0,
        //     "Only approved distributors can deliver drug products"
        // );
        lot_number = _lot_number;
        state = State.Distributing;
        product_distributors.push(distributors[msg.sender]);
        order_start_distribution = now;

    }

    function transferDistributing(address from) public {
        // require(
        //     distributors[msg.sender].name > 0,
        //     "Only approved distributors can transfer drug product delivery"
        // );
        // require(
        //     distributors[from].name > 0,
        //     "Not correct original approved drug distributor"
        // );
        state = State.between_Distributors;
        product_distributors.push(distributors[msg.sender]);
    }

    function approveDrugTransfer(address to) public {
        // require(
        //     distributors[msg.sender].name > 0,
        //     "Only approved distributors can transfer drug product delivery"
        // );
        // require(
        //     distributors[to].name > 0,
        //     "Only approved distributors can receive a transfered drug product"
        // );
        state = State.Distributing;
    }

    function endDistributing() public {
        // require(
        //     distributors[msg.sender].name > 0,
        //     "Only approved distributors can end drug product delivery"
        // );
        state = State.wait_Recv;
        order_end_distribution = now;
    }

    function approveReceive() public {
        // require(
        //     msg.sender == product_provider,
        //     "Only order may approve receiving final drug substance"
        // );
        state = State.Received;
        order_received_timestamp = now;

    }

    function patientTransfer() public {
        // require(
        //     msg.sender == product_provider,
        //     "Only the provider can say they transfered the drug to the patient"
        // );
        state = State.Patient;
        order_to_patient_timestamp = now;
    }

    event TemperatureMax(int temp);
    event TemperatureMaxTarget(int temp);
    event TemperatureMinTarget(int temp);
    event TemperatureMin(int temp);

    function updateTemperature(int _in_temp) public {
        temperature = _in_temp;
        if(temperature > max_temperature){
            emit TemperatureMax(temperature);
            damaged_product = true;
        }else if(temperature > max_target_temperature){
            emit TemperatureMaxTarget(temperature);
        }else if(temperature < min_temperature){
            emit TemperatureMin(temperature);
            damaged_product = true;
        }else if(temperature < min_target_temperature){
            emit TemperatureMinTarget(temperature);
        }
    }
}