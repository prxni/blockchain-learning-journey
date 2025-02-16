# IPFS
## **The Centralized Internet Today**

- The internet is central to our lives for media consumption, communication, learning, and finance management.
- **Problem**: Data is stored on centralized server farms controlled by single companies.

### **Risks of Centralization**

- **Vulnerability to Outages**: Loss of access if platforms like YouTube or Wikipedia go offline.
- **Censorship**: Governments can easily block content on centralized servers.
    - Example: Turkey blocked Wikipedia in 2017, citing national security concerns.

### **Why Centralization Persists**

- High expectations for speed and quality of content delivery.
- Centralized servers provide better control for companies to meet demands.
- Lack of viable, fast alternatives—until now.

## **Introducing IPFS**

- **What is IPFS?** A decentralized, peer-to-peer (P2P) network for file sharing.
- **Goal**: To create a fully distributed web, similar to BitTorrent.

### **Current Web Model: Location-Based Addressing**

- Content is accessed by location (e.g., IP address or domain).
- If the server hosting the content is down, access is impossible.
- Even if others have the file, your system won’t retrieve it from them.

### **How IPFS Works: Content-Based Addressing**

- Content is identified by a unique hash (like a fingerprint) instead of a location.
- Files are retrieved by their hash, ensuring integrity and security.

#### **Built-In Security with Hashes**

- Hashes verify file integrity.
- Matching the requested and received hash ensures no tampering.

#### **Efficiency through Deduplication**

- Files with identical hashes are stored only once, reducing redundancy and enhancing efficiency.

### **How IPFS Stores Files**

- Files are split into **IPFS objects**:
    - Each object stores up to 256 KB of data.
    - Larger files are split into multiple objects, linked together.
    - Small files (e.g., "Hello World") fit into a single object.

#### **Handling Files Larger Than 256 KB**

- Larger files are divided into multiple 256 KB IPFS objects.
- An empty IPFS object links these pieces into a complete structure.
- This architecture allows IPFS to mimic a filesystem with directories and files.

## **Immutability and Versioning in IPFS**

- **Immutability**: Files added to IPFS cannot be changed.
- **Versioning**: Changes create a **commit object** linking to the previous version.
    - Enables file history tracking and seamless updates.

### **Challenge: File Availability**

- Files on IPFS rely on nodes that cache them.
- If all nodes hosting a file go offline, it becomes inaccessible, similar to BitTorrent without seeders.

### **Solutions for File Availability**

- **Incentivize Storage**: Reward nodes for storing and sharing files.
- **Proactive Distribution**: Ensure files have multiple copies across the network.

## **Filecoin: Extending IPFS**

- **What is Filecoin?**
    - A blockchain-based decentralized marketplace for storage, created by the IPFS team.
- **How It Works**:
    - Users rent out storage space and earn rewards.
    - Files are replicated across nodes to ensure availability.
- **Benefits**:
    - Sustainable decentralized storage ecosystem.
    - Improved reliability and resilience of IPFS.

## **IPFS in Action: Real-World Applications**

### **Censorship Resistance: Turkish Wikipedia Example**

- In 2017, the Turkish government blocked access to Wikipedia.
- The creators of IPFS responded by uploading a copy of the Turkish Wikipedia onto IPFS.
- **Why it works**: Since IPFS is decentralized and has no central servers, the government could not block access to it.

### **DTube: Decentralized Video Platform**

- **DTube** is a decentralized alternative to YouTube, hosted entirely on IPFS.
- Anyone can upload videos and contribute to supporting the network, enabling censorship-resistant content sharing.

### **The Interplanetary File System**

- **Why “Interplanetary”?**
    - The idea behind the name is that IPFS can operate across different planets, making it suitable for interplanetary communication.
    - Example: On Mars, the time delay between Earth and Mars ranges from **4 to 24 minutes**.
        - Requesting a page from Earth could take up to **8 minutes** in the best-case scenario, and **48 minutes** on a bad day.

### **How IPFS Can Overcome Planetary Communication Delays**

- **Caching on Mars**:
    - With IPFS, large parts of the internet can be cached on Mars itself.
    - If someone has already requested a page, it can be retrieved from a node on Mars, reducing the travel time significantly.
    - This allows webpages to load almost as quickly as they would on Earth.

### **Conclusion**

- IPFS is an ambitious project that not only aims to decentralize the internet but could also make it possible to distribute content across multiple planets, effectively overcoming the challenges of long-distance communication.
- The technology is already being used for censorship resistance and decentralized video sharing, demonstrating its potential for transforming how we interact with and share information.