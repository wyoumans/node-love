'use strict';

describe('Home page', function() {

  describe('Header', function() {
    it('should contain a logo');
    it('should contain navigation with a download button');
    it('should go to the github page when the user clicks on the download button');
  });

  describe('Body', function() {
    it('should contain content loaded from the database');
  });

  describe('Footer', function() {
    it('should contain a copyright indication');
  });
});
