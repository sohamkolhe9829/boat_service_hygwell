import { useState } from "react";
import CheckBoxField from "./components/CheckBoxField";
import { ref, uploadBytes, getDownloadURL } from "firebase/storage";
import { addDoc, collection, getDocs } from "firebase/firestore";
import { storage, db } from "../firebase-config";
import { CloudUploadIcon } from "lucide-react";

//Function for removing unnessery nulls from the list
const removeNullsFromList = (list) => {
  return list.filter((item) => item !== null).map((item) => item);
};

function App() {
  //Select Files
  const [files, setFiles] = useState([]);

  const handleDrop = (e) => {
    e.preventDefault();
    const droppedFiles = Array.from(e.dataTransfer.files);
    setFiles(droppedFiles);
  };

  const handleFileChange = (e) => {
    const selectedFiles = Array.from(e.target.files);
    setFiles(selectedFiles);
  };

  const handleDragOver = (e) => {
    e.preventDefault();
  };

  //Upload Files

  const uploadFiles = async () => {
    var images = [];
    for (let i = 0; i < files.length; i++) {
      const imageRef = ref(storage, `/boats/${files[i].name}`);

      const result = await uploadBytes(imageRef, files[i])
        .then(async (value) => {
          images.push(await getDownloadURL(value.ref));
          console.log("success");
        })
        .catch((error) => {
          console.log("error");
        });
      console.log(result);
    }
    console.log(images);
    await handleDataStoring({ images });
  };

  //Store to firestore
  const handleDataStoring = async ({ images }) => {
    const data = {
      name: name,
      capacity: capacity,
      images: images,
      amenities: removeNullsFromList([
        emenities1 ? "Clean Restrooms" : null,
        emenities2 ? "Comfortable Sitting arrangements" : null,
        emenities3 ? "Onboarding Dining" : null,
        emenities4 ? "Wi-Fi Access" : null,
        emenities5 ? "Entertainment System" : null,
        emenities6 ? "Air Conditioning/Climate Control" : null,
      ]),
      safetyFeatures: removeNullsFromList([
        safety1 ? "Live food provided to all passengers" : null,
        safety2 ? "Emergency Kit onboard" : null,
        safety3 ? "Fire Extinguishers" : null,
      ]),
      description:
        "This hotel features air-conditioned cabins, plush seating, and an onboard dining area servng delicious local cuisine.",
    };
    console.log(data);
    const valRef = collection(db, "boats");

    await addDoc(valRef, data);
    alert(`Boat ${name} added successfully`);
  };

  //Emenities Variables
  const [emenities1, setEmenities1] = useState(false);
  const [emenities2, setEmenities2] = useState(false);
  const [emenities3, setEmenities3] = useState(false);
  const [emenities4, setEmenities4] = useState(false);
  const [emenities5, setEmenities5] = useState(false);
  const [emenities6, setEmenities6] = useState(false);

  const handleEmenitiesChange1 = (event) => {
    setEmenities1(event.target.checked);
  };
  const handleEmenitiesChange2 = (event) => {
    setEmenities2(event.target.checked);
  };
  const handleEmenitiesChange3 = (event) => {
    setEmenities3(event.target.checked);
  };
  const handleEmenitiesChange4 = (event) => {
    setEmenities4(event.target.checked);
  };
  const handleEmenitiesChange5 = (event) => {
    setEmenities5(event.target.checked);
  };
  const handleEmenitiesChange6 = (event) => {
    setEmenities6(event.target.checked);
  };

  //Safety Features variables
  const [safety1, setSafety1] = useState(false);
  const [safety2, setSafety2] = useState(false);
  const [safety3, setSafety3] = useState(false);
  const handleSafetyChange1 = (event) => {
    setSafety1(event.target.checked);
  };
  const handleSafetyChange2 = (event) => {
    setSafety2(event.target.checked);
  };
  const handleSafetyChange3 = (event) => {
    setSafety3(event.target.checked);
  };

  //Variables
  const [name, setName] = useState("");
  const handleSetName = (event) => {
    setName(event.target.value);
  };
  const [capacity, setCapacity] = useState("");
  const handleSetCapacity = (event) => {
    setCapacity(event.target.value);
  };

  return (
    <div className="">
      {/* Header component */}
      <h1 className="text-3xl py-3 px-10 text-primaryColor">GTM</h1>

      <div className="grid grid-cols-12 border-t-2 border-dashed border-secondaryColor">
        {/* Navigation Components */}
        <div className="bg-blue-500 border-r border-secondaryColor col-span-2 p-5 h-full">
          <ul>
            <li>
              {" "}
              <button className="text-black p-5">Dashboard</button>
            </li>
            <li>
              {" "}
              <button className="text-black p-5">Manage Bookings</button>
            </li>
            <li>
              <button className="text-white pl-5 pr-12 py-3 bg-primaryColor rounded ">
                Manage Boats
              </button>
            </li>
            <li>
              <button className="text-black p-5">Manage Meals</button>
            </li>
            <li>
              <button className="text-black p-5">Manage Pricing</button>
            </li>
          </ul>
        </div>
        {/* Form Components */}
        <div className=" col-span-10 ">
          <h2 className="p-8 text-2xl">Add Boat</h2>
          <div className=" border-t  border-secondaryColor "> </div>
          {/* Form of adding boat */}
          <div className="p-8 w-3/4">
            <h3> Name</h3>
            <input
              type="text"
              placeholder="Enter the name of the boat"
              id="name"
              onChange={handleSetName}
              className="mt-1 px-2 py-1 block w-full border border-gray-300 rounded-md shadow-sm focus:border-indigo-500 focus:ring focus:ring-indigo-500 focus:ring-opacity-50"
              required
            />
            <br />
            <h3> Capacity</h3>
            <input
              type="text"
              placeholder="Enter number of seats on the boat"
              id="capacity"
              onChange={handleSetCapacity}
              className="w-1/2 mt-1 px-2 py-1 block w-full border border-gray-300 rounded-md shadow-sm focus:border-indigo-500 focus:ring focus:ring-indigo-500 focus:ring-opacity-50"
              required
            />
            <br />
            <div className="  border-secondaryColor border-t-2 border-dashed"></div>
            <br />

            {/* Selecting Images Component */}
            <h3> Photo</h3>
            <h3 className="text-subtitleColor">Upload photos of your boat</h3>
            <div className="max-w  p-4 ">
              <label htmlFor="fileInput">
                <div
                  onDrop={handleDrop}
                  onDragOver={handleDragOver}
                  className="cursor-pointer h-96 flex flex-col items-center justify-center p-8 border-2 border-dashed border-secondaryColor rounded-md hover:border-indigo-500 transition duration-150 ease-in-out"
                >
                  <img src="" alt="" />
                  <input
                    id="fileInput"
                    type="file"
                    multiple
                    onChange={handleFileChange}
                    className="hidden"
                  />
                  {/* <div className="flex justify-center items-center h-screen">
                  </div> */}
                  <CloudUploadIcon className="text-primaryColor" />
                  <br />
                  <p className="text-xl  ">
                    Drag & drop files here, or Click to select files
                  </p>
                  <p className="text-subtitleColor text-l">
                    {" "}
                    Supports JPG, PNG, and SVG files up to 1MB
                  </p>
                </div>
              </label>
              {files.length > 0 && (
                <div className="mt-4">
                  <h4 className="text-lg font-medium">Selected Files:</h4>
                  <ul className="mt-2 space-y-1">
                    {files.map((file, index) => (
                      <li key={index} className="text-gray-700">
                        {file.name}
                      </li>
                    ))}
                  </ul>
                </div>
              )}
            </div>
            <div className="  border-t-2 border-secondaryColor border-dashed"></div>
            <br />
            {/* Selecting Amenities Component*/}
            <h3 className="text-bold"> Amenities</h3>
            <p className="text-subtitleColor">
              Select the amenities available on your boat to enhance passenger
              comfort and experience.
            </p>
            <ul>
              <li>
                <CheckBoxField
                  label="Clean Restrooms"
                  checked={emenities1}
                  onChange={handleEmenitiesChange1}
                />
              </li>
              <li>
                <CheckBoxField
                  label="Comfortable Sitting Arrangements"
                  checked={emenities2}
                  onChange={handleEmenitiesChange2}
                />
              </li>
              <li>
                <CheckBoxField
                  label="Onboarding Dining"
                  checked={emenities3}
                  onChange={handleEmenitiesChange3}
                />
              </li>
              <li>
                <CheckBoxField
                  label="Wi-Fi Access"
                  checked={emenities4}
                  onChange={handleEmenitiesChange4}
                />
              </li>
              <li>
                <CheckBoxField
                  label="Entertainment System"
                  checked={emenities5}
                  onChange={handleEmenitiesChange5}
                />
              </li>
              <li>
                <CheckBoxField
                  label="Air Conditioning/Climate Control"
                  checked={emenities6}
                  onChange={handleEmenitiesChange6}
                />
              </li>
            </ul>
            <br />
            <div className="  border-t-2 border-secondaryColor border-dashed"></div>
            <br />
            {/* Selecting  Safety Features Component*/}
            <h3 className="text-bold"> Safety Features</h3>
            <p className="text-subtitleColor">
              Select the safety features available on your boat to enhance
              passenger Safety.
            </p>
            <ul>
              <li>
                <CheckBoxField
                  label="Live food provided to all passengers"
                  checked={safety1}
                  onChange={handleSafetyChange1}
                />
              </li>
              <li>
                <CheckBoxField
                  label="Emergency Kit onboard"
                  checked={safety2}
                  onChange={handleSafetyChange2}
                />
              </li>
              <li>
                <CheckBoxField
                  label="Fire Extinguishers"
                  checked={safety3}
                  onChange={handleSafetyChange3}
                />
              </li>
            </ul>
            <br />
            <div className="  border-t-2 border-secondaryColor border-dashed"></div>
            <br />
            {/* Selecting Meals Component*/}
            <h3 className="text-bold"> Meals</h3>
            <p className="text-subtitleColor">
              Select the available meals on your boat.
            </p>
            <ul>
              <li>
                <CheckBoxField label="Veg/Non veg" />
              </li>
              <li>
                <CheckBoxField label="Pure Veg" />
              </li>
            </ul>
            <br />
            <div className="  border-t-2 border-secondaryColor border-dashed"></div>
            <br />
            {/* Button for saving data to cloud database */}
            <div className="flex justify-end">
              <button
                className="bg-primaryColor py-2 px-12 rounded text-white "
                onClick={uploadFiles}
              >
                Save
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
