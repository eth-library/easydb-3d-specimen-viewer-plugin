import { SpecimenViewer3D } from "3d-specimen-viewer";
import "./App.css";

function App() {
  const query = new URLSearchParams(window.location.search);
  const asset: string | null = query.get("asset");

  if (!asset) {
    return <h1>No asset specified.</h1>;
  }

  return (
    <div className="App specimen-3d-viewer-full-size">
      <SpecimenViewer3D src={asset} />
    </div>
  );
}

export default App;
