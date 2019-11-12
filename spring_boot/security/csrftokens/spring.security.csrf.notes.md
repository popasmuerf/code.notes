Spring security and CsrfTokenRepository
https://www.baeldung.com/spring-security-csrf

1.  Overview

In this tutorial, we will discuss Cross-Site Request Forgery CSRF attacks and how to prevent
them using Spring Security

2FFvv
2. GET Examples

Let's consider the following GET rquest used by logged in users to transfer money to 
specific bank account "1234" 


GET http://bank.com/transfer?accountNo=1234&amount=1


If the attacker wants to tranfer money from a victim's account to his own account instead "5678"
he needs to make the victim trigger the request...


GET http://bank.com/transfer?accountNo=5678&amount=1000




There are multiple ways to make that happen"

	*	Link:  the attack can convince the victim to click on this link for example.
		, to execute the transfer:

		<a href="http://bank.com/transfer?accountNo=5678&amount=1000">
		Show Kittens Pictures
		</a>



	*	Image: The attacker may use an <img/> tag with the target URL as the image source
		-- so the click isn't even necessary. The request will be automatically executed
		when the page loads

		<img src="https://bank.com/transfer?acountNo=5678&amount=100"/>



3. POST Example

If the main request needs to be POST request -- for example:


POST http://bank.com/transfer
accountNo=5678&amount=1000


Neither the '<a>' nor the '</img>' will work in this case.  The attacker  will need a 
'<form>' as follows:

<form action="http://bank.com/transfer" method="POST">
    <input type="hidden" name="accountNo" value="5678"/>
    <input type="hidden" name="amount" value="1000"/>
    <input type="submit" value="Show Kittens Pictures"/>
</form>


...and we could ust use javascript as so to send the request ...


	<body onload="document.forms[0].submit()">
<form>



So in summary.... a CSRF(cross site request forgery) attack is basically using someone else's credentials
to do the work for you...


Now that we understand how a CSRF attack looks like, let's simulate these examples within a Spring app.

We're going to start with a simple controller implementation- the BankController:


	@Controller
	public class BankController {
	    private Logger logger = LoggerFactory.getLogger(getClass());
	 
	    @RequestMapping(value = "/transfer", method = RequestMethod.GET)
	    @ResponseBody
	    public String transfer(@RequestParam("accountNo") int accountNo, 
	      @RequestParam("amount") final int amount) {
		logger.info("Transfer to {}", accountNo);
		...
	    }
	 
	    @RequestMapping(value = "/transfer", method = RequestMethod.POST)
	    @ResponseStatus(HttpStatus.OK)
	    public void transfer2(@RequestParam("accountNo") int accountNo, 
	      @RequestParam("amount") final int amount) {
		logger.info("Transfer to {}", accountNo);
		...
	    }
	}


And let's also have a basic HTML page that triggers the bank transfer operation:

<html>
<body>
    <h1>CSRF test on Origin</h1>
    <a href="transfer?accountNo=1234&amount=100">Transfer Money to John</a>
     
    <form action="transfer" method="POST">
        <label>Account Number</label> 
        <input name="accountNo" type="number"/>
 
        <label>Amount</label>         
        <input name="amount" type="number"/>
 
        <input type="submit">
    </form>
</body>
</html>



This is the page of the main application, running on the origin domain.

Note that we've simulated both a GET through a simple link as well as a POST through a simple <form>.

Now – let's see how the attacker page would look like:

<html>
<body>
    <a href="http://localhost:8080/transfer?accountNo=5678&amount=1000">Show Kittens Pictures</a>
     
    <img src="http://localhost:8080/transfer?accountNo=5678&amount=1000"/>
     
    <form action="http://localhost:8080/transfer" method="POST">
        <input name="accountNo" type="hidden" value="5678"/>
        <input name="amount" type="hidden" value="1000"/>
        <input type="submit" value="Show Kittens Picture">
    </form>
</body>
</html>




The above page(the cracker's html) 
will run on a different domain...that of the cracker's...
finally let's run th two applications -- the orginal and th atacker application -- locally, an d
let's access the original page first..



