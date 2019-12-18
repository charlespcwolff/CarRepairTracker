export default {
    /**
     * Returns the authentication token from local storage.
     * @function
     */
    getToken() {
      return localStorage.getItem("Authorization");
    },
    /**
     * Parses and saves the authentication token.
     * @param {String} token A JWT encoded token.
     */
    saveToken(token) {
      localStorage.setItem("Authorization", token);
    },
    /**
     * Invalidates the local authentication token.
     */
    destroyToken() {
      localStorage.removeItem("Authorization");
    },

    hasToken() {
      let token = this.getToken();
      return token != null;
    },

  isEmpOrAdmin() {
    return this.getUser().rol =='Employee' || this.getUser().rol == 'Administrator';
  },
  isAdmin() {
    return this.getUser().rol =='Administrator';
  },
  
    /**
     * Returns the user represented by the authentication token
     * @returns null if expired or user is not authenticated).
     * @function
     */
    getUser() {
      const token = localStorage.getItem("Authorization");
      let user = null;
  
      try {
        // If a token exists then decode it
        if (token) {
          const base64Url = token.split(".")[1];
          const base64 = base64Url.replace(/-/g, "+").replace(/_/g, "/");
          const secondsSinceEpoch = new Date() / 1000;
          const parsedToken = JSON.parse(window.atob(base64));
          // If current date is after expiration date then destroy it
          if (secondsSinceEpoch > parsedToken.exp) {
            this.destroyToken();
          } else {
            user = parsedToken;
          }
        }
      }
      catch (ex) {
        this.destroyToken();
      }
  
      return user;
    }
  };