describe("User listing", function() {

  beforeEach(function() {
    loadFixtures("user_listing.html");
  });

  it("should add the previous page to the history", function() {
    spyOnEvent($(".next_page"), 'click');
    $(".next_page").click();
    expect('click').toHaveBeenTriggeredOn($('.next_page'));
  });

  
});