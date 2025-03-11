### Project Overview 🏗️

This project implements a feature using an Outside-In approach, ensuring a clean and scalable architecture.
These are some of the desicions, trade-offs that lead the development. 

Architectural Decisions & Implementation Details

1. I opted for a `Modularized-Monolith`, where we have separated concerns residing within each of their respecitve package, i.e: `Domain`, `Data` and `Network`. And the main project would output one build artifact. 

2. Lifecycle & SceneDelegate Removal
	-	The `SceneDelegate` has been removed since multi-scene support is unnecessary for this project and it depends soley on the `AppDelegate` as the entry point for our app. 

3. Naming Conventions
	-	`DTOs` (Data Transfer Objects) are explicitly named with the DTO suffix.
	-	Presentation Models are suffixed with `PresentationModel`.
	-	Domain Models have no prefix or suffix.

4. Development Approach `Outside-In`
	-	The feature was developed using an Outside-In approach, focusing on driving development from the UI down to the domain and data layers.
	-	This ensured a user-centric flow, refining dependencies as the implementation evolved.

5. Filters Collection View Placement
  - The filters are placed inside a header view to provide a better scrolling experience. 🚀

6. Image Loader Simplification
  - Modeled as a singleton with thread-safety considerations in place for concurrent image requests and cancelation.  
	-	No error handling was added for the image loading. Failure states we're simply modeled as nil, while success returns the image.

7. View Controller Organization
	-	The ViewController could have been split into multiple files for extra organization, but I kept them in a single file for the simplicity of this project.
