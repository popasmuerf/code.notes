#What is ML ?

ML involves  algorithms that learn rules or parterns from 
data to achieve a goal such as minimizing a predication error.


Ultimately, the goal of active investment management is 
generate alpha,  defined as protfolio returns in
exess of the benchmark used for evaluation.


##Fundamental law of active management (FLAM)
    -   Postulates that the key
        to generating alphais having 
        accurate return forecasts combined with 
        the ability to act on these forecasts
        
    -   The **Inforamtion Ration**(IR) is defined
        by the **Fundamental Law of Active Management**
   
    -   IR is a ratio of the return difference between
        the portfolio and a benchmack to the volatility
        of those returns.
        
    -   FLAM futher approximates the IR of the product as following
        -   The **information coefficient(IC)**, which measures the
            quality of forecasts as their rank correlation with outcomes
            
        -   The square root of the breadth of a strategy expressed as the 
            number of independent bets on these forecasts
            
            
            
The competion of sophisticated investors in financial markets implies that
making precise prediction to generate alpha requires superior information, either
through access to better data, a superior ability to process it, or both.


This is where ML comes in: application of **ML for trading (ML4T)** 
typically aim to make more efficent use of a rapidly diversifying range of data to
produce both better and more actionable forecasts, thus imporvoing the 
quality of investment decistion and results.
            
            
##The rise of ML in the investment industry

-   Changes in **market microstructure** , such as the spread
    of electronic trading and  the integration of markets across 
    asset classes and geographies
    
-   The development of investment strategies framed in terms of
    **risk-factor**, as opposed to asset classes
    
-   The revolutions in  
    -   data generation
    -   managment
    -   statistical methods
    -   breakthorughs in ML
    
-   Outperformance of the pioneers in algorithmic
    trading relative to human, discretionary investors  
    -   The revolutions in  
        -   data generation
        -   managment
        -   statistical methods
        -   breakthorughs in ML
        -   **Rise in low-cost passive investment vehicles**
            -   ***exchange-traded funds (ETFS)***
                -   Amid low yields and low volatility following
                    the 2008 crisis, which triggered large-scale
                    asset puchages by leadning cetnral banks, cost concious
                    investors shifted over 3.5 trillion fromactively
                    managed mutual funds into mapssively managed ETFs**
                               
        
        

##From electronic to high-frequency trading

Electronic trading has advanced dramatically in terms of
    -Volume
    -Coverage
    -Capability
    -Geographies
    
since networks stared routing prices to
computer terminals in the 1960s.

Equity markets have been at the forefront of this
trend worldwide.  


##Electroinic communication networks(ECNs).

ECNs are automated alternative trading systems(ATS) that
that match buy-and sell orders at specifed prices,
primarily for equities and curriences, and are registerd as
broker-dealers.  It allows significant brokerages and
individual trades in differnt geographic locations
to trade directly without intermediaries, both on 
exchanges and after hours.


##Dark Pools
    -Another alternative to Alternative Trading Systems(ATS)
    -Allows for institutional investors to 
     trade large ordes without publicly revealing their information,
     contrary to how exchanges managed their order books prior to
     competition from ECNs
    -Dark pools do not publish pre-trade bids and offers, and traide prices
     only beome public some time after execution.  They have grown
     substantially since the mid-2000s to account for 40 percent
     of equities traded in th eUS due to concerns about adverse price
     movements of large orders and order front-running by high-frequency 
     traders.
    -They are often housed within large banks and are subject to SEC regulation
    
##Algorithms for cost-effective execution
    -Developed rapidly and adopted quickly from both the
        -sell side
        -buy side
        -asset classes
        
    -Automated trding emered arnoud 2000 as a sell side tool
     aimed at cost-effective execution that borke down orders
     into smaller, sequenced chunks to limit their market impact.
     
    -These tools spread to the buy side and became increasingly sophisticated
     by taking into account, for example, transaction costs and liquidity, as well
     as short-term price and volume forecasts.
     
##Direct market access(DMA) 
    -gives a trader greater control over execution
     via allowing them to send orders directly to th exchange using the infrastructure
     and market participant identification of a broker who is a member of an exchange.
     Sponsred access removes pre-trade risk controls by the brokers and forms the
     basis for **high-frequency trading (HFT)***
  
##High-Frequency Trading(HFT)
    -HFT refers to automated trades in financial instruments that
     are executed with extremely low lantency in the microsecond 
     range and where participants hold posistions for very short periods.
    -The goal is to detect and exploit inefficiences in the 
     market microstructure, the institutional infrastructure of trading venues.
    -HFT has grown substantially over the past 10 years and is
     estimated to make up roughly 55 percent of trading volume in US equity
    -HFT has also grown in futures markets to roughly 80 percent
     of Foreign-exchange futures volumes and two-thrids of both interest rate
     and Treasury 10-year futures volumes
    -HFT strategies aim to earn small profits per trade using 
     passive or aggressive strategies.
     
##Passive or Aggressive Strategies of HFT
    -Passive strategies i8nclude arbitrage trading to profit from 
     very small price differentials for the same asset, or its derivatives
     traded on different venues.
    -Aggressive strategies include order anticipation or momentum ignition
    -Order anticipation, also known as liquidity detection involves
        1. Order anticpation/liquidity detection
        2. Algorithms that submit small exploratory orders to 
           detect hidden liquidity from large institutional investors
           and trade ahead of a large order to benefit from subsequent price
           movments.  
        3. Momentum Ignitions implies an algorithm executing and canceling a 
           series of orders to spoof other HFT algorithms into buying
           (or selling) more aggressively and and benefit from the
           resultig prices changes.
    -Aggressive Strategies are of some concern to regulators as they have a direct
     effect on the the general volitility of the market.
        1. Flash Crash of May 2010
        2. Treasury Market volitility
        3. 1,000 point Dow Jones  crash of August 24, 2015.
    -Despite the down-sides  of HFT....these methodologies have actually
     generally increased the liquidity of the market as volume of trades have
     significantly diminished while significantly lowering the cost of 
     said trades....while also adding to general market pressure...the
     democratization of the market via HFT has dropped the revenues derived from
     equities from just beneach 1 billion in 2017 for the first time 
     since 2008 , down from 7.9 billion in 2009.
     
    -The reductive affect of HFT on equity profitability has lead to the
     frequency of industry consolidation, with various aquistions by corporations
    

##NOTE...What are Equities ?
-   Equities are the same thing as stocks
-   Whenever you buy a stock...you are buying an equity
-   Equities(Stocks) don't pay a fixed interest rate(hence the reason
    why companies tend to offer stock to raise funds instead of taking out
    loans..
    
    
##Factor investing and smart beta funds

1. The return provided by an asset is a function of the
uncertainty or risk associated with the investment.
An equity investment implies, for example, assuming a company's
business risk, and a bond investment entails defualt risk

2. ***Specific risk characteristics predict returns***
    -   Identifying and forecasting the behavior of these
        risk factors becomes a primary focus
        when designing an investment strategy.
        
    -   Yields valuable trading signals and is the key to
        superior active management results.
        
3. ***Modern portfolio theory (MPT) ***
    -   Introduced the distinction between idiosyncratic
        and systematic sources of risk for a given asset.
        
    -   Idiosyncratic risk can be eliminated through diversification.
    
    -   Systematic risk can not be eliminated through diversifiction
        or any via any other strategem because they all exist within
        the system.
        
4.  ***Capital asset pricing model(CAPM)***
    -   Identified a single factor driving all capital returns;
        the return on the market portfolio in ecess of T-Bills.
        
    -   The market porotfolio consisted of all tradable securities,
        weighted by their market value.
        
    -   The systematic exposure of an asset to the market is measured
        **beta**, which is the correlation between the returns
        of the asset and the market portfolio
        
    -   Assets earn a ***risk premium** based on their exposure to
        underlying, **common risks** experienced by all assets, not
        due to their specific, idiosyncratic characteristics.
    


##Designing and executing an ML-Driven strategy
    
    -   Driven by data sources that contain predictive signals
        for the target universe and strategy
    
    -   Suitable preprocessing and feature engineering that allows
        for the ML model to predict asset returns or other
        strategy inputs
        
    -   The model predicions, in turn, translate into buy or sell
        orders based on human discretion or autmated rules which are 
        either
            -   manually encoded 
            -   learned by another ML algorithm in and
                end-to-end approach
                
                
                             The ML4T Workflow




 +------------------------------+  +---------------+       +----------------+     +-------------------+
 |ata Sources                   |  | Point-in-Time |       |Factor & Feature|     | ML Models         |
 |                              +->+ Adjustments   +------>+Engineering     +---> | *Models design    |
 |                              |  +---------------+       +----------------+     | *Parameter Tuning |
 |arket  fundamental alternative|                                                 | *Cross-Validation |
 |                              |                                                 +------+------------+
 |                              |                                                        |
 +------------------------------+                                                        |
                                                                                         v
+--------------+      +------------------+      +------------------------+     +---------+--------+
|Execution     |      | Live Portfolio   |      |Monitoring & Evaluation |     |Predictions       |
|              |      | Symbol  Position |      |*Risk Management        |     |*Risk Factors     |
|Global Markets+----> | ------  -------- +----->+*Performance            +---->+*Prices & Returns |
|              |      | Amzn    5000     |      |*Attribution            |     |*Covariance       |
+-------+------+      | Uber    1500     |      +------------------------+     |                  |
        ^             | V       -350     |                                     +-----------+------+
        |             +------------------+                                                 |
        |                                                                                  v
+-------+-------------------+     +------------------+     +--------------------+   +------+----------+
|Orders                     |     | Target Portfolio |     |Portfolio           |   |Asset Selection  |
|Symbol Order Shares Limit  |     | Symbol  Position |     |Optimizer           |   |*Rule-based      |
+-----  ----- ------ -----  |     | ------  -------- |     |*Asset Allocation   |   |*Model-based     |
|AMZN   BUY   200    123.45 | <---+ AMZN    3800     | <---+*Sector Weights     +<--+*Bet Sizing      |
|V      SELL  50     321.21 |     | V       2300     |     |*Risk-Return Profile|   |                 |
|UBER   SELL  250    145.83 |     | UBER    -500     |     |                    |   |                 |
|                           |     +------------------+     +--------------------+   +-----------------+
+---------------------------+


##The ML4T Workflow

###Sourcing and managing data important data sources
The dramatic evolution of data availability in terms of
-   variety
-   velocity
-   volume

are all key complements to the application of 
ML to trading, which in turn has
boosted industry spending on the acquisition of
new data sources.

However, the proliferating supply of data requires careful
selection and management to uncover the potential value,
including the following steps:

1.Identify and evaluate the following data sources
  for alpha signals that do not decay too quickly
    -   market
    -   fundamental
    -   alterantive 
  
2.Deploy or access a cloud-based scalable data infrastructure and analytical
tools like Hadoop or Spark to facilitate fast, flexible data access


3. Carefully manage and curate data to avoid look-ahead bias by
   adjusting it to the desired frequency on a point-in-time basis.
   This means that data should reflect only information available
   and known at the given time.  ML algorithms trained on
   distored historical data will almost certainly fail 
   during live trading
   
   
####From alpha factor research to protfolio management
Alpha factors are designed to extract signals from data to 
predict returns for a given investment universe over the trading 
horizon.


***The alpha factor research process***

                           Research
                           --------

+------------+      +------------+    +----------+     +-----------+
| Get        |      | Define     |    | Design   |     | Combine   |
| Predictive +----->+ Investment +--->+ Alpha    +---->+ Alpha     |
| Data       |      | Universe   |    | Factors  |     | Factors   |
+------------+      |            |    |          |     |           |
                    +------------+    +----------+     +-----+-----+
                                                             |
                                                       +-----v-----+
                                  Execution            |  Optimize |
                                  ----------           |  Portfolio|
                                                       +-----+-----+
                                                             |
                                                       +-----v-----+
                                                       |  Execute  |
                                                       |  Trades   |
                                                       |           |
                                                       +-----------+

1. Research Phase
    -Design and evaluation of alpha factors
    -Predictive factors
        -Captures some aspect of systematic relationship
         between a data source and an important strategy input
         like asset returns
        -Optimizing the predictive power requires create
         feature enginering inthe form of effective
         data transformations.
        -False discoveries due to data mining are key
         risk that requires careful management
        -Risk do to false discoveries is to focus
         the search process by following the guidance
         of decades of academic research that has
         produced several Nobel prizes.
        -Many investors still prefer factors that
         align with theories about financial 
         markets and investor behavior.
    -Validating the signal content of an alpha factor
        - **Robust Estimate of its Predictive Power**
          in a representiative context.
        - There are numberous methodological
          and practial pitfalls that undermine a reliable
          estimate.  In addition to data mining
          and the failure to correct for multple testing bias,
          not reflecting realistic **Princidple, Interest and Taxes (PIT)**
          information
2. Execution Phase


###Engineering informative features or alpha factors to extract Alpha signals


###Managing portfolio and tracking strategy performance









































    
 
