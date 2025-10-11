import { SpecimenViewer3D } from "3d-specimen-viewer";
import "./App.css";

function App() {
  const query = new URLSearchParams(window.location.search);
  const assetParam = query.get("asset");
  const filenameParam = query.get("original_filename");
  const fileType = query.get("type");
  // Ensure parameters are properly decoded
  const asset: string | null = assetParam
    ? decodeURIComponent(assetParam)
    : null;
  const originalFilename: string | null = filenameParam
    ? decodeURIComponent(filenameParam)
    : null;

  if (!asset) {
    return <h1>No asset specified.</h1>;
  }

  if (originalFilename) {
    document.title = originalFilename;
  }

  return (
    <div className="App specimen-3d-viewer-full-size">
      <SpecimenViewer3D
        src={asset}
        fileName={originalFilename}
        fileType={fileType}
      />
    </div>
  );
}

export default App;
