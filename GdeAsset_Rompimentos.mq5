/*
; saved on 2024.05.14 22:33:23
; this file contains input parameters for testing/optimizing Beta09_Alterado06 expert advisor
; to use it in the strategy tester, click Load in the context menu of the Inputs tab
;
TesteReal=false||false||0||true||N
iMAGIC=9986655511||1243||1||12430||N
iLote=1||2.0||0.200000||20.000000||N
iOffSet=2||2||1||20||N
tempo1=30||0||0||49153||N
tempo2=1||0||0||49153||N
iComment=BETA09
UtilizarBE=true||false||0||true||N
fatorATR=0.1||0.4||0.040000||4.000000||N
fatorFibo=1.10||0.5||0.050000||5.000000||N
ifatorBE=1||1||1||10||N
iMultParcial=2.6||0.5||0.050000||5.000000||N
iSaidaNaParcial=true||false||0||true||N
; SMA
smaPeriod=3||7||1||70||N
smaShift=0||0||1||10||N
smaMode=0||0||0||3||N
smaPrice=2||1||0||7||N
; UOS
uosFastPeriod=3||3||1||30||N
uosMiddlePeriod=4||4||1||40||N
uosSlowPeriod=7||7||1||70||N
uosFastK=1||1||1||10||N
uosMiddleK=4||4||1||40||N
uosSlowK=3||3||1||30||N
uosSup=70.0||70.0||7.000000||700.000000||N
uosInf=30.0||30.0||3.000000||300.000000||N
; ATR
atrPeriod=1||3||1||30||N
iAcumulacao=true||false||0||true||N
; BOLLINGER
bbPeriod=7||7||1||70||N
bbShift=0||0||1||10||N
bbDeviation=1.618||1.618||0.161800||16.180000||N
bbPrice=1||1||0||7||N
; GATOR OSCILATOR
utilGator=true||false||0||true||N
InpJawsPeriod=7||7||1||70||N
InpJawsShift=4||4||1||40||N
InpTeethPeriod=4||4||1||40||N
InpTeethShift=3||3||1||30||N
InpLipsPeriod=3||3||1||30||N
InpLipsShift=1||1||1||10||N
InpMAMethod=2||0||0||3||N
InpAppliedPrice=2||1||0||7||N
; HORÁRIO/TIME
LocalTime=2||0||0||2||N
iIniHr=9||0||0||23||N
iIniMn=10||0||0||55||N
iFnlHr=10||0||0||23||N
iFnlMn=40||0||0||55||N
iDerr=10||0||0||55||N
; DESENHO DOS PASSOS
dPBO1=true||false||0||true||N
dPBO2=true||false||0||true||N
dExpansao=true||false||0||true||N
; PAINEL/PANEL
TamFonte=11||11||1||110||N
Fonte=0||0||0||2||N
iFX=1.0||1.0||0.100000||10.000000||N
ShowPeriodSep=false||false||0||true||N
; CORES/COLORS
clr_buyTrend1=16711680
clr_buyTrend2=16748574
clr_sellTrend1=16711935
clr_sellTrend2=7504122
clr_foreground=16436871
clr_background=0
clr_Candle_Bull=0
clr_Chart_Up=32768
clr_Candle_Bear=0
clr_Chart_Dn=255
clr_Chart_Line=16777215
clr_pbackground=0
clr_edtbg=6701572
Font1=15128749
Font2=16119285
Font3=16119285
clr_ButtonBuy=32768
clr_BtFontBuy=16777215
clr_ButtonSell=3618815
clr_BtFontSell=16777215
clr_ButtonClose=128
clr_BtFontClose=16777215


Alterado 5 foi descartado. Este é o 3 com fechamento + correção do multiplicador de parcial para o alvo


(vídeo)
Então quando tem o pbo1, ao surgir o pbo2 inverso ele não anula. Ele tem que acumular o pbo2?

Na época, já tinha funções de pbo novo anular o anterior. Então tem que mudar para acumular o pbo2?

Preciso que me responda isso que perguntei e que escreva TODAS as alterações que quer nesse robô. Fazer as alterações todas juntas é melhor para o resultado final. Alterar em pequenas partes não é bom.




Olá, Galvão

Beta49: colocar janela "Fator Ticks (multiplicador de ticks no passo9)" Igual no GdeAsset2.1
Quando tem esse fator, vc fala que tem erro. Que acontece na hora errada. Daí, tirei para não acontecer mais esse erro. Ok, coloquei de volta.

Beta9_alterado: também colocar janela "Fator Ticks (multiplicador de ticks no passo9)" Igual no GdeAsset2.1
Como estava sem no 49, e era para fazer similar, ficou sem. Mas posso colocar.

Beta9_alterado: Verificar Motivo que Não funcionou "Fator Fibo (multilicador de distância para Brekeven)"
O ponto 1.618 fica na distância de 0.618. O multiplicador tem que ficar com o valor da distância.

Beta9_alterado: colocar janela "Fazer saída total no ponto da Parcial com Multiplicador para a parcial" para fechar operações
Já fiz esse orçamento. Se for adicionar o TP, normalmente é rápido de fazer. Fechamento total ou parcial por distância é uma função do mesmo tamanho de uma função de trailing stop. Tem que fazer varredura, análise, comparação e decisão. Não é algo de 5 minutos.

Sobre o breakeven, eliminei alguns filtros que poderiam causar essas questões que vc falou. Testei aqui, e parece que essas situações foram cobertas.


*/

/*
Então no beta 9 seria: breakeven+ acumulação+ gator oscilator + a régua passa a ser a 3a barra nessas condições após pbo2

BE: VerificaStops do GDE 1_16
Acumulação: fPasso6 - feito, falta validar -
Gator: direto na decisão do gde 1_46

Verificar se são 3 barras depois do pbo. Se for, verifica tudo. Senão, não. - OK, validado


*/
//+------------------------------------------------------------------+
//|                                                   Acumulacao.mq5 |
//+------------------------------------------------------------------+
#property copyright "Daniel de Almeida Galvão"
#property link      "https://www.mql5.com/pt/users/admpartinvest"
#property version   "1.00"

#define lim1 10
//#define lim2 6
enum ENUM_FONTE
  {
   Arial,         // Arial
   Calibri,       // Calibri
   LucidaConsole  // Lucida Console
  };


enum ENUM_HOURS
  {
   hour_00  =0,   // 00
   hour_01  =1,   // 01
   hour_02  =2,   // 02
   hour_03  =3,   // 03
   hour_04  =4,   // 04
   hour_05  =5,   // 05
   hour_06  =6,   // 06
   hour_07  =7,   // 07
   hour_08  =8,   // 08
   hour_09  =9,   // 09
   hour_10  =10,  // 10
   hour_11  =11,  // 11
   hour_12  =12,  // 12
   hour_13  =13,  // 13
   hour_14  =14,  // 14
   hour_15  =15,  // 15
   hour_16  =16,  // 16
   hour_17  =17,  // 17
   hour_18  =18,  // 18
   hour_19  =19,  // 19
   hour_20  =20,  // 20
   hour_21  =21,  // 21
   hour_22  =22,  // 22
   hour_23  =23,  // 23
  };

enum ENUM_MINUTES
  {
   min_00   =0,   // 00
   min_05   =5,   // 05
   min_10   =10,   // 10
   min_15   =15,   // 15
   min_20   =20,   // 20
   min_25   =25,   // 25
   min_30   =30,   // 30
   min_35   =35,   // 35
   min_40   =40,   // 40
   min_45   =45,   // 45
   min_50   =50,   // 50
   min_55   =55,   // 55
  };

enum ENUM_LocalTime
  {
   HoraLocal,      // Local
   HoraAbsoluta,   // GMT
   HoraCorrente    // Broker
  };

//--- input parameters
input bool  TesteReal = false;
input long        iMAGIC            = 1243; // Magic
input double iLote = 2;
input int iOffSet = 2;
input ENUM_TIMEFRAMES tempo1 = PERIOD_M12;  // Tempo 1
input ENUM_TIMEFRAMES tempo2 = PERIOD_M4;   // Tempo 2
//input ENUM_TIMEFRAMES tempo3 = PERIOD_M1;   // Tempo 3
input string iComment = "BETA09"; // Comentário nas Ordens
input bool UtilizarBE = true; // Utilizar Breakeven
input double      fatorATR = 0.4;         // Fator ATR (multiplicador do ATR no Breakeven)
input double      fatorFibo = 0.5;        // Fator Fibo (multiplicador de distância para Breakeven)
input int         ifatorBE = 1;            // Fator Ticks (multiplicador de ticks no Breakeven)

int fatorBE=1;

input double      iMultParcial = 2; // Multiplicador para parcial
input bool     iSaidaNaParcial = true;//Fazer saída total no ponto da Parcial

input group    "SMA";
input int      smaPeriod = 7; // Período MA
input int      smaShift = 0; // Shift MA
input ENUM_MA_METHOD smaMode = MODE_SMA; // MA Mode
input ENUM_APPLIED_PRICE smaPrice = PRICE_OPEN; // MA Price

input group     "UOS";
input int uosFastPeriod=3;     // Fast ATR period
input int uosMiddlePeriod=4;  // Middle ATR period
input int uosSlowPeriod=7;    // Slow ATR period
input int uosFastK=1;          // Fast K
input int uosMiddleK=4;        // Middle K
input int uosSlowK=3;          // Slow K
input double uosSup = 70;      // Nível SobrePreço Superior
input double uosInf = 30;      // Nível SobrePreço Inferior

input group     "ATR";
input int  atrPeriod = 3;
input bool iAcumulacao = true; // Acumulação cancela a operação

input group     "BOLLINGER";
input int       bbPeriod = 7;
input int       bbShift   = 0;
input double    bbDeviation = 1.618;
input ENUM_APPLIED_PRICE bbPrice= PRICE_CLOSE;


input group "GATOR OSCILATOR";
input bool        utilGator = true;       // Utilizar Gator Oscilator
input int                InpJawsPeriod=7;                // Jaws period
input int                InpJawsShift=4;                 // Jaws shift
input int                InpTeethPeriod=4;               // Teeth period
input int                InpTeethShift=3;                // Teeth shift
input int                InpLipsPeriod=3;                // Lips period
input int                InpLipsShift=1;                 // Lips shift
input ENUM_MA_METHOD     InpMAMethod=MODE_SMMA;          // Moving average method
input ENUM_APPLIED_PRICE InpAppliedPrice=PRICE_OPEN;     // Applied price


input group             "HORÁRIO/TIME";
input ENUM_LocalTime    LocalTime             = HoraCorrente;// Time Reference
input ENUM_HOURS        iIniHr                = hour_09;     // Start Hour
input ENUM_MINUTES      iIniMn                = min_15;      // Start Minute
input ENUM_HOURS        iFnlHr                = hour_16;     // End Hour
input ENUM_MINUTES      iFnlMn                = min_30;      // End Minute
input ENUM_MINUTES      iDerr                 = min_15;      // Minutes to Close ALL (zero = swingtrade)


input group       "DESENHO DOS PASSOS";
input bool        dPBO1 = true;
input bool        dPBO2 = true;
//input bool        dPBO3 = true;
input bool        dExpansao = true; // Expansão (por enquanto, apenas passo 3)


input group       "PAINEL/PANEL";
input int         TamFonte          = 11;                      // Font Size
input ENUM_FONTE  Fonte             = Arial ;                  // Font Name
input double      iFX               = 1.0;                     // Adjust (1=default)
input bool        ShowPeriodSep     = false;                   // Show Period Sep

input group       "CORES/COLORS";
input color       clr_buyTrend1     = clrBlue;                 // Tendência de Compra Tempo 1
input color       clr_buyTrend2     = clrDodgerBlue;           // Tendência de Compra Tempo 2
//input color       clr_buyTrend3     = clrLightBlue;            // Tendência de Compra Tempo 3

input color       clr_sellTrend1    = clrMagenta;              // Tendência de Venda Tempo 1
input color       clr_sellTrend2    = clrSalmon;               // Tendência de Venda Tempo 2
//input color       clr_sellTrend3    = clrPink;                 // Tendência de Venda Tempo 3

input color       clr_foreground    = clrLightSkyBlue;         // Foreground
input color       clr_background    = clrBlack;                // Background
input color       clr_Candle_Bull   = clrBlack;      // Candle Bull
input color       clr_Chart_Up      = clrGreen;      // Chart Up
input color       clr_Candle_Bear   = clrBlack;               // Candle Bear
input color       clr_Chart_Dn      = clrRed;               // Chart Down
input color       clr_Chart_Line    = clrWhite;                // Chart Line
input color       clr_pbackground   = clrBlack;                // Panel Background
input color       clr_edtbg         = C'4,66,102';             // Fundo Editáveis
input color       Font1             = clrLightBlue;            // Titles
input color       Font2             = clrWhiteSmoke;           // Standard Font
input color       Font3             = clrWhiteSmoke;           // Fonte Editáveis
input color       clr_ButtonBuy          = clrGreen;                // Button Buy
input color       clr_BtFontBuy          = clrWhite;                // Button Buy Font
input color       clr_ButtonSell         = C'255,55,55';               // Button Sell
input color       clr_BtFontSell         = clrWhite;                // Button Sell Font
input color       clr_ButtonClose        = clrMaroon;               // Button Close
input color       clr_BtFontClose        = clrWhite;                // Button Close Font


#include <Trade\Trade.mqh>
#include <Trade\SymbolInfo.mqh>
#include <Trade\AccountInfo.mqh>
CTrade         m_trade;                      // trading object
CAccountInfo   m_account;                    // account info wrapper
CSymbolInfo    m_symbol;                   // symbol info object Buy

//Geral
bool inicio=false;
double ASK=0,BID=0;
long nMAGIC;
//indicadores
int sma_handle1=-1;
int sma_handle2=-1;
//int sma_handle3=-1;
int uos_handle1=-1;
int uos_handle2=-1;
//int uos_handle3=-1;
int atr_handle1=-1;
int atr_handle2=-1;
//int atr_handle3=-1;
int bb_handle1=-1;
int bb_handle2=-1;
//int bb_handle3=-1;

int gator_handle = -1;

//Painel
string FONTE;
//long Chart1,Chart2,Chart3;

//Operações
double LoteComprado=0,LoteVendido=0;
double dVol=0,PassoVolume=0;
double dLote=0;
double VolParcial=0,divSymbol=0,Espaco=0,OffSet=0,BE=0;
string TTMargem="";

double LucroAbertas=0;
bool     DeveSairCompra=false,DeveSairVenda=false,Prossegue=false;

datetime dAgora;
MqlDateTime mdt1,mdt2;
long lAgora,Hoje,Ontem=0;
long Iniciar,Finalizar,Derrubar;
string dHoje,dHojeBroker;
bool funciona = false;

// Estratégia
int Trend1=0,Trend2=0;//,Trend3=0;
int aTrend1=0,aTrend2=0;//,aTrend3=0;
datetime dtBuy1=0,dtSell1=0,dtBuy2=0,dtSell2=0;//,dtBuy3=0,dtSell3=0;
datetime gdt2=0;//,gdt3=0;
int limite1=80;
long LnB1=0;
long LnS1=0;
long LnB2=0;
long LnS2=0;
long LnB3=0;
long LnS3=0;
double PassoDistancia=0;
double PrecoBE=0,PrecoSL=0,Entrada=0;
string Expansao="";
int iExp=0;

int            SinalEntrada=0;
double         PrecoAberturaBuy=0;
double         PrecoAberturaSell=0;

double SLbuy=0,SLsell=0,TPbuy=0,TPsell=0;

datetime ConfPBO2=0;
datetime barraPBO3;

double Preco50=0,oPreco50=0;
double pParcial=0,oParcial=0;
double Alvo=0;
//bool Operou=false;

bool CancelouAcumulacao = false;
//+---------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Indicadores()
  {

   sma_handle1 = iMA(Symbol(),tempo1,smaPeriod,smaShift,smaMode,smaPrice);
   if(Period()==tempo1 || tempo1==PERIOD_CURRENT)
      ChartIndicatorAdd(0,0,sma_handle1);
   bb_handle1=iBands(Symbol(),tempo1,bbPeriod,bbShift,bbDeviation,bbPrice);
   if(Period()==tempo1 || tempo1==PERIOD_CURRENT)
      ChartIndicatorAdd(0,0,bb_handle1);

   uos_handle1=iCustom(Symbol(),tempo1,"ultimate_oscillator.ex5",uosFastPeriod,uosMiddlePeriod,uosSlowPeriod,uosFastK,uosMiddleK,uosSlowK);
   if(Period()==tempo1 || tempo1==PERIOD_CURRENT)
      ChartIndicatorAdd(0,1,uos_handle1);

   atr_handle1=iATR(Symbol(),tempo1,atrPeriod);
   if(Period()==tempo1 || tempo1==PERIOD_CURRENT)
      ChartIndicatorAdd(0,2,atr_handle1);

   sma_handle2 = iMA(Symbol(),tempo2,smaPeriod,smaShift,smaMode,smaPrice);
   if(Period()==tempo2 || tempo2==PERIOD_CURRENT)
      ChartIndicatorAdd(0,0,sma_handle2);
   bb_handle2=iBands(Symbol(),tempo2,bbPeriod,bbShift,bbDeviation,bbPrice);
   if(Period()==tempo2 || tempo2==PERIOD_CURRENT)
      ChartIndicatorAdd(0,0,bb_handle2);

   uos_handle2=iCustom(Symbol(),tempo2,"ultimate_oscillator.ex5",uosFastPeriod,uosMiddlePeriod,uosSlowPeriod,uosFastK,uosMiddleK,uosSlowK);
   if(Period()==tempo2 || tempo2==PERIOD_CURRENT)
      ChartIndicatorAdd(0,1,uos_handle2);

   atr_handle2=iATR(Symbol(),tempo2,atrPeriod);
   if(Period()==tempo2 || tempo2==PERIOD_CURRENT)
      ChartIndicatorAdd(0,2,atr_handle2);


   if(utilGator)
     {
      gator_handle=iGator(Symbol(),tempo2,InpJawsPeriod,InpJawsShift,InpTeethPeriod,InpTeethShift,InpLipsPeriod,InpLipsShift,InpMAMethod,InpAppliedPrice);
      if(Period()==tempo2 || tempo2==PERIOD_CURRENT)
         ChartIndicatorAdd(0,3,gator_handle);
     }

//Operou=false;
   /*
   sma_handle3 = iMA(Symbol(),tempo3,smaPeriod,smaShift,smaMode,smaPrice);
   if(Period()==tempo3 || tempo3==PERIOD_CURRENT)
      ChartIndicatorAdd(0,0,sma_handle3);

   bb_handle3=iBands(Symbol(),tempo3,bbPeriod,bbShift,bbDeviation,bbPrice);
   if(Period()==tempo3 || tempo3==PERIOD_CURRENT)
      ChartIndicatorAdd(0,0,bb_handle3);

   uos_handle3=iCustom(Symbol(),tempo3,"ultimate_oscillator.ex5",uosFastPeriod,uosMiddlePeriod,uosSlowPeriod,uosFastK,uosMiddleK,uosSlowK);
   if(Period()==tempo3 || tempo3==PERIOD_CURRENT)
      ChartIndicatorAdd(0,1,uos_handle3);

   atr_handle3=iATR(Symbol(),tempo3,atrPeriod);
   if(Period()==tempo3 || tempo3==PERIOD_CURRENT)
      ChartIndicatorAdd(0,2,atr_handle3);
   */
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void InicializaValores()
  {

   DadosAtivo();
   PreparaFundoTela();
   limite1=lim1;
   LnB1=0;
   LnS1=0;
   LnB2=0;
   LnS2=0;
   LnB3=0;
   LnS3=0;
   iExp=0;
  }
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer

   inicio=false;


   CalculaHorario();
   InicializaValores();
   Indicadores();

   gdt2=iTime(m_symbol.Name(),tempo2,40);
//gdt3=iTime(m_symbol.Name(),tempo3,40);

//EventSetTimer(60);
   ChartRedraw(0);
   inicio=true;
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
// EventKillTimer();
//ObjectsDeleteAll(0);
//LimpaIndicadores();

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   if(!inicio)
      return;

   if(!trade_session())
      return;

   if(!RefreshRates())
      return;


   Agora();

   AjustaImediato();

   if(DeveSairCompra || DeveSairVenda)
     {
      //if(VerificaFinal)         Print("DeveSairCompra=",DeveSairCompra,", DeveSairVenda=",DeveSairVenda);

      if(DeveSairCompra)
        {
         if(LoteComprado>0)
            ArrastaSLgrudado(1);
         else
            DeveSairCompra=false;
        }

      if(DeveSairVenda)
        {
         if(LoteVendido>0)
            ArrastaSLgrudado(-1);
         else
            DeveSairVenda=false;

        }
      return;
     }

   /*
      if(LoteComprado+LoteVendido>0 || !funciona)
        {
         if(!TesteReal)
            VerificaStops();

         return;
        }*/
   /*
      if(!TesteReal)//  && !Operou)
        {
         //if(AnaliseBB && !Cancelamento)

        }
   */


   static datetime prev_time1=0;
   if(prev_time1!=iTime(Symbol(),tempo1,0)) // Virada tempo1
     {
      prev_time1=iTime(Symbol(),tempo1,0);
      //Print("limite1=",limite1);
      if(limite1<0)
         limite1=0;

      datetime ConfPBO1=0;
      PBO(1,tempo1,dtBuy1,dtSell1,limite1+3,Trend1,aTrend1,ConfPBO1);
      //Print("PBO1=",Trend1);

      datetime fim=dtSell1;
      if(dtBuy1>dtSell1)
         fim=dtBuy1;

      if(Trend1!=0)
         gdt2=fim;


      //Print("prev=",prev_time1,", fim=",fim);
      limite1=Bars(m_symbol.Name(),tempo1,prev_time1,fim);
      if(limite1>lim1)
         limite1=lim1;
      //if(limite1<1)
      //if(Trend1!=aTrend1 && Trend1!=0)
      //   {
      /*
      if(dPBO1)
         DesenhaLn(1,Trend1,fim);*/
      //aTrend1=Trend1;
      // }
     }

   static datetime prev_time2=0;
   if(prev_time2!=iTime(Symbol(),tempo2,0)) // Virada tempo2
     {
      prev_time2=iTime(Symbol(),tempo2,0);
      datetime ini=prev_time2;
      /*if(Trend1==1)
         dt2=dtBuy1;
      if(Trend1==-1)
         dt2=dtSell1;*/
      //datetime fim=dtSell1;
      //if(dtBuy1>dtSell1)
      //if(Trend1==1)
      //fim=dtBuy1;
      if(gdt2>0)
        {
         //Print("gdt2=",gdt2);
         //Print("Trend1=",Trend1);

         int limite2=Bars(m_symbol.Name(),tempo2,ini,gdt2);
         PBO(2,tempo2,dtBuy2,dtSell2,limite2,Trend2,aTrend2,ConfPBO2);
         //Print("PBO2=",Trend2,", 1=",Trend1);

        }
      datetime data1,data2;//,data3,dtSupera,dtConfirm;
      double Preco1,Preco2,D12;//Preco3,Preco0681;//,PrecoSL;

      //PicoVolatilidade(limite3,Trend1,Preco1,data1,Preco2,data2,dtSupera,dtConfirm,Preco0681);
      //Entrada=0;
      if(CalculaBarra3(Trend1,Trend2,ConfPBO2,data1,data2,Preco1,Preco2,D12))
        {
         Retracao(Trend2,data1,data2,Preco1,Preco2,D12);
        }

     }



   if(!TesteReal)
     {
      if(LoteComprado+LoteVendido==0)
        {

         Decisao();
        }
      else
         VerificaStops();
     }

   static datetime prev_timeM1=0;
   if(prev_timeM1!=iTime(Symbol(),PERIOD_M1,0)) // Virada tempo1
     {
      prev_timeM1=iTime(Symbol(),PERIOD_M1,0);
      if(TesteReal)
        {
         if(LoteComprado+LoteVendido==0)
           {
            Decisao();
           }
         else
            VerificaStops();
        }
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Decisao()
  {
   if(!funciona)
      return;

//if(Operou)      return;

   string Recado="";
   /*
   Acumulacao();
   if(CancelouAcumulacao)
     {
      Recado="Acumulação cancelou a operação.";
      //Print(Recado);
      return;
     }
   if(utilGator)
     {
      //double gator0[1],gator1[1],gator2[1],gator3[1];
      double gator1[1],gator3[1];
      //CopyBuffer(gator_handle,0,0,1,gator0);
      CopyBuffer(gator_handle,1,0,1,gator1);
      //CopyBuffer(gator_handle,2,0,1,gator2);
      CopyBuffer(gator_handle,3,0,1,gator3);
      //vermelho = 1
      //verde = 0
      bool podeOperar=false;
      if(gator1[0]==gator3[0])
        {
         if(gator1[0]==0 && Trend1==1)//verde + tendencia de compra
            podeOperar=true;
         if(gator1[0]==1 && Trend1==-1)//vermelho + tendência de venda
            podeOperar=true;
        }
      if(!podeOperar)
        {
         Recado="Gator cancelou operação.";
         //Print(Recado);
         return;
        }
     }
     */
   Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol;

   if(dLote>0.0)
     {
      if(Trend1==1 && Trend2==1 && ASK>PrecoAberturaBuy && PrecoAberturaBuy>0)
        {

         if(!m_trade.Buy(dLote,m_symbol.Name(),ASK,SLbuy,TPbuy,iComment))
            Recado="Falha na compra.";
         else
           {
            Recado="Compra OK";
            oPreco50=Preco50;
            oParcial=pParcial;
            PrecoAberturaBuy=0;
            //oPreco100=Preco100;
            //Operou=true;
           }
         //Print(Recado,PrecoAberturaBuy);
        }
      if(Trend1==-1 && Trend2==-1 && BID<PrecoAberturaSell && PrecoAberturaSell>0)
        {
         if(!m_trade.Sell(dLote,m_symbol.Name(),BID,SLsell,TPsell,iComment))
            Recado = "Falha na venda.";
         else
           {
            Recado="Venda OK";
            oPreco50=Preco50;
            oParcial=pParcial;
            PrecoAberturaSell=0;
            //oPreco100=Preco100;
            //Operou=true;

           }
         //Print(Recado," - ",PrecoAberturaSell);
        }
     }

  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
/*void OnTimer()
  {
//---
   if(!inicio)
      return;
  }*/
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---

  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RefreshRates()
  {
//if(VerificaOp)      Print(__FUNCTION__);
//--- refresh rates
   if(!m_symbol.RefreshRates())
      return(false);
//--- protection against the return value of "zero"
   ASK=SymbolInfoDouble(m_symbol.Name(),SYMBOL_ASK);
   BID=SymbolInfoDouble(m_symbol.Name(),SYMBOL_BID);
   if(ASK == 0 || BID == 0)
      return(false);

   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool trade_session()
  {
   ENUM_DAY_OF_WEEK day_of_week=SUNDAY;
   datetime time_now = TimeCurrent();
   MqlDateTime time;
   TimeToStruct(time_now, time);
   uint week_day_now = time.day_of_week;
   uint seconds_now = (time.hour * 3600) + (time.min * 60) + time.sec;
   if(week_day_now == 0)
      day_of_week = SUNDAY;
   if(week_day_now == 1)
      day_of_week = MONDAY;
   if(week_day_now == 2)
      day_of_week = TUESDAY;
   if(week_day_now == 3)
      day_of_week = WEDNESDAY;
   if(week_day_now == 4)
      day_of_week = THURSDAY;
   if(week_day_now == 5)
      day_of_week = FRIDAY;
   if(week_day_now == 6)
      day_of_week = SATURDAY;
   datetime from, to;
   uint session = 0;
   while(SymbolInfoSessionTrade(_Symbol, day_of_week, session, from, to))
     {
      session++;
     }
   uint trade_session_open_seconds = uint(from);
   uint trade_session_close_seconds = uint(to);
   if(trade_session_open_seconds < seconds_now && trade_session_close_seconds > seconds_now && week_day_now >= 1 && week_day_now <= 5)
      return(true);
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DadosAtivo()
  {
//if(iMAGIC==0)
   nMAGIC=iMAGIC;
   if(nMAGIC<1)
     {
      MessageBox("O número mágico deve ser maior que zero");
      ExpertRemove();
     }
   m_symbol.Name(Symbol());
   m_trade.SetExpertMagicNumber(nMAGIC);            // sets magic number
   m_trade.SetTypeFilling(ORDER_FILLING_RETURN);   //Para corretora Modal

   PassoVolume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);
   if(!RefreshRates())
     {
      Sleep(300);
      RefreshRates();
     }

   double minLote=SymbolInfoDouble(m_symbol.Name(),SYMBOL_VOLUME_MIN);
   double divLote=SymbolInfoDouble(m_symbol.Name(),SYMBOL_VOLUME_STEP);

   if(iLote>0)
     {
      dLote=iLote;
      CalculoVolume();
     }
   else
     {
      //dLote=iVolumeFin/ASK;
      dLote=minLote;
      CalculoVolume();
     }

   VolParcial=MathCeil((dLote/2)/PassoVolume)*PassoVolume;
   if(VolParcial>=dLote)
     {
      VolParcial=MathFloor((dLote/2)/PassoVolume)*PassoVolume;;
      if(VolParcial>=dLote)
         VolParcial=0;
     }

   divSymbol   = SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_SIZE);
   Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol;

   OffSet=iOffSet*divSymbol;

   fatorBE=ifatorBE;


//    BE = MathCeil(iBE*_Point/divSymbol)*divSymbol;
//    SL_Fixo=MathCeil(iSL*_Point/divSymbol)*divSymbol;
//    TP_Fixo=MathCeil(iTP*_Point/divSymbol)*divSymbol;
//    TrailingFixo=MathCeil(iTrailingFixo*_Point/divSymbol)*divSymbol;
//    dParcial=MathCeil(iParcial*_Point/divSymbol)*divSymbol;

//if(iBE==0 && SL_Fixo>0)      BE=SL_Fixo;
// * * * * * * * * * * * * * * * * * * *

   if(PassoVolume>=1)
      dVol=0;
   if(PassoVolume<1 && PassoVolume>=0.1)
      dVol=1;
   if(PassoVolume<0.1 && PassoVolume>=0.01)
      dVol=2;
   if(PassoVolume<0.01 && PassoVolume>=0.001)
      dVol=3;
   if(PassoVolume<0.001 && PassoVolume>=0.0001)
      dVol=4;
   if(PassoVolume<0.0001 && PassoVolume>=0.00001)
      dVol=5;
   if(PassoVolume<0.00001 && PassoVolume>=0.000001)
      dVol=6;
   if(PassoVolume<0.000001 && PassoVolume>=0.0000001)
      dVol=7;
   if(PassoVolume<0.0000001)
      dVol=8;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void PreparaFundoTela(long Chart=0,int Tipo=1)
  {
   FONTE = AjustaFONTE();

   if(Tipo != 1)
     {

      ChartSetInteger(Chart, CHART_SHOW_GRID, false);
      ChartSetInteger(Chart, CHART_MODE, CHART_CANDLES);
      ChartSetInteger(Chart,CHART_SHOW_PERIOD_SEP,false);
      ChartSetInteger(Chart,CHART_COLOR_FOREGROUND,clr_foreground);
      ChartSetInteger(Chart,CHART_COLOR_BACKGROUND, clr_background);
      ChartSetInteger(Chart, CHART_COLOR_CANDLE_BULL, clr_background);
      ChartSetInteger(Chart, CHART_COLOR_CHART_UP, clr_background);//clrDodgerBlue);
      ChartSetInteger(Chart, CHART_COLOR_CANDLE_BEAR, clr_background);//clr_background);
      ChartSetInteger(Chart, CHART_COLOR_CHART_DOWN, clr_background);//clrSteelBlue);
      ChartSetInteger(Chart, CHART_COLOR_CHART_LINE, clr_background);//clrDodgerBlue);
      ChartSetInteger(Chart, CHART_COLOR_LAST, clr_background);//clrRed);
      ChartSetInteger(Chart, CHART_COLOR_BID, clr_background);//clrGray);
      ChartSetInteger(Chart, CHART_COLOR_ASK, clr_background);//clrGray);
     }
   else
     {

      // Seta as cores da barra de alta
      ChartSetInteger(Chart, CHART_COLOR_CANDLE_BULL, clr_Candle_Bull);//- C'10,10,10');
      ChartSetInteger(Chart, CHART_COLOR_CHART_UP, clr_Chart_Up);//- C'10,10,10');
      // Seta as cores da barra de baixa
      ChartSetInteger(Chart, CHART_COLOR_CANDLE_BEAR, clr_Candle_Bear);//- C'10,30,30');
      ChartSetInteger(Chart, CHART_COLOR_CHART_DOWN, clr_Chart_Dn);//- C'10,30,30');
      //Seta a cor da barra de indecisão
      ChartSetInteger(Chart, CHART_COLOR_CHART_LINE, clr_Chart_Line);//- C'30,30,30');

      ChartSetInteger(Chart, CHART_SHOW_GRID, false);
      ChartSetInteger(Chart,CHART_COLOR_FOREGROUND,clr_foreground);//Detalhes);
      //ChartSetInteger(0,CHART_COLOR_
      // Seta como gráfico de candles
      ChartSetInteger(Chart, CHART_MODE, CHART_CANDLES);
      ChartSetInteger(Chart,CHART_SHOW_PERIOD_SEP,ShowPeriodSep);

      ChartSetInteger(Chart, CHART_COLOR_BACKGROUND, clr_background);

      ChartSetInteger(Chart,CHART_SHOW_ASK_LINE,true);
      ChartSetInteger(Chart,CHART_SHOW_BID_LINE,true);
      ChartSetInteger(Chart, CHART_COLOR_BID, clrGray);
      ChartSetInteger(Chart, CHART_COLOR_ASK, clrRed);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string AjustaFONTE()
  {
   switch(Fonte)
     {
      case Arial:
         return "Arial";
         break;
      case Calibri:
         return "Calibri";
         break;
      case LucidaConsole:
         return "Lucida Console";
         break;
      default:
         return "Calibri";
         break;
     }
   return "Arial";
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void PBO(int Qual,ENUM_TIMEFRAMES tempo,datetime &TempoBuy,datetime &TempoSell,int limite,int &Tendencia,int &aTendencia,datetime &TempoPBOConfirm)//,int TrendFilter)
  {

//int RetVal = 0; //Tednência Confirmada
//Passo1_MediaSMA = smaopen
//if(Qual==2)      Print("Limite do 2 = ",limite,", TrendFilter=",TrendFilter);

   if(limite<2)
      return;

//Print("Tempo=",Qual);
//Tendencia=0;

   double Open[],High[],Low[],Close[],sma[];
   datetime Time[];
   ArrayResize(Open,limite);
   ArrayResize(High,limite);
   ArrayResize(Low,limite);
   ArrayResize(Close,limite);
   ArrayResize(Time,limite);
   ArrayResize(sma,limite);

   CopyOpen(Symbol(),tempo,0,limite,Open);
   CopyHigh(Symbol(),tempo,0,limite,High);
   CopyLow(Symbol(),tempo,0,limite,Low);
   CopyClose(Symbol(),tempo,0,limite,Close);
   CopyTime(Symbol(),tempo,0,limite,Time);

   switch(Qual)
     {
      case 1:
         CopyBuffer(sma_handle1,0,0,limite,sma);
         break;
      case 2:
         CopyBuffer(sma_handle2,0,0,limite,sma);
         break;

     }
//Print("Verif: ",Time[limite-1]);


   int limitePBO=limite;
   datetime TempoGatilhoBuy=0,TempoGatilhoSell=0;
   double GatilhoBuy=0,GatilhoSell=0;
// ArrayResize(GatilhoBuy,5);
//ArrayResize(GatilhoSell,5);
//ArrayResize(TempoGatilhoBuy,5);
//ArrayResize(TempoGatilhoSell,5);

   for(int i=0; i<limitePBO; i++)
     {
      //(1)
      if(i<limite-2)
        {
         //Print("limite=",limite,", i=",i,", Open=",Open[i],", Time=",Time[i]);
         //um sobe, acima da média, 2 desce, 3 abre acima da média e fecha acima da abertura do 2
         //if(TrendFilter!=-1)
         if(Open[i]<Close[i] && Close[i]>sma[i] && Open[i+1]>sma[i+1] && Open[i+1]>Close[i+1] && Open[i+2]>sma[i+2] && Close[i+2]>=Open[i+1])// && (GatilhoBuy<Open[i+2] || GatilhoBuy==0))
           {
            if(GatilhoBuy!=Open[i+2])
              {
               /*for(int j=4; j>0; j--)
                 {
                  GatilhoBuy[j]=GatilhoBuy[j-1];
                  TempoGatilhoBuy[j]=TempoGatilhoBuy[j-1];
                 }*/
               GatilhoBuy=Open[i+2];
               TempoGatilhoBuy=Time[i+2];
               //if((dPBO1 && Qual==1)||(dPBO2 && Qual==2)||(dPBO3 && Qual==3))                     Print("Gat Colocado: tempo=",Qual,", Gatilho compra = ",GatilhoBuy,", TempoGat=",TempoGatilhoBuy,", sma=",sma[i],", tempo sma=",Time[i]);
              }

           }
         //if(TrendFilter!=1)
         if(Open[i]>Close[i] && Close[i]<sma[i] && Open[i+1]<sma[i+1] && Open[i+1]<Close[i+1] && Open[i+2]<sma[i+2] && Close[i+2]<=Open[i+1])// && (GatilhoSell>Open[i+2] || GatilhoSell==0))
           {
            if(GatilhoSell!=Open[i+2])
              {
               /* for(int j=4; j>0; j--)
                  {
                   GatilhoSell[j]=GatilhoSell[j-1];
                   TempoGatilhoSell[j]=TempoGatilhoSell[j-1];
                  }*/
               GatilhoSell=Open[i+2];
               TempoGatilhoSell=Time[i+2];
               //if((dPBO1 && Qual==1)||(dPBO2 && Qual==2)||(dPBO3 && Qual==3))                     Print("Gat Colocado: tempo=",Qual,", Gatilho Venda = ",GatilhoSell,", TempoGat=",TempoGatilhoSell,",sma=",sma[i],", tempo sma=",Time[i]);
              }
           }

         /*if(High[i]>sma[i] && Close[i]>Open[i] && Open[i+1]>sma[i+1] && Close[i+1]<Open[i+1] && Open[i+2]>sma[i+2] && Close[i+2]>=Open[i+2])
            GatilhoBuy=Open[i+2];

         if(Low[i]<sma[i] && Close[i]<Open[i] && Open[i+1]<sma[i+1] && Close[i+1]>Open[i+1] && Open[i+2]<sma[i+2] && Close[i+2]<=Open[i+2])
            GatilhoSell=Open[i+2];*/
         //if(sma[i+3]>=GatilhoBuy){Tendencia=1;TempoBuy=Time[i+3];return;}
         //(2)

        }
      if(i<limite-1)
        {
         //if(TrendFilter!=-1)
         if(Open[i+1]>sma[i+1] && High[i+0]>sma[i+0] && ((Open[i+1]>High[i+0])||(Close[i+1]>=High[i+0])) && Close[i+1]>=Open[i+1])// && (GatilhoBuy<Open[i+1] || GatilhoBuy==0))
           {
            if(GatilhoBuy!=Open[i+1])
              {
               /*for(int j=4; j>0; j--)
                 {
                  GatilhoBuy[j]=GatilhoBuy[j-1];
                  TempoGatilhoBuy[j]=TempoGatilhoBuy[j-1];
                 }*/
               GatilhoBuy=Open[i+1];
               TempoGatilhoBuy=Time[i+1];
               //if((dPBO1 && Qual==1)||(dPBO2 && Qual==2)||(dPBO3 && Qual==3))                     Print("Gat Colocado2: tempo=",Qual,", Gatilho compra = ",GatilhoBuy,", TempoGat=",TempoGatilhoBuy,", sma=",sma[i],", tempo sma=",Time[i]);
              }
           }
         //if(TrendFilter!=1)
         if(Open[i+1]<sma[i+1] && Low[i+0]<sma[i+0] && ((Open[i+1]<Low[i+0])||(Close[i+1]<=Low[i+0])) && Close[i+1]<=Open[i+1])// && (GatilhoSell>Open[i+1] || GatilhoSell==0))
           {
            if(GatilhoSell!=Open[i+1])
              {
               /*for(int j=4; j>0; j--)
                 {
                  GatilhoSell[j]=GatilhoSell[j-1];
                  TempoGatilhoSell[j]=TempoGatilhoSell[j-1];
                 }*/
               GatilhoSell=Open[i+1];
               TempoGatilhoSell=Time[i+1];
               //if((dPBO1 && Qual==1)||(dPBO2 && Qual==2)||(dPBO3 && Qual==3))                     Print("Gat Colocado2: tempo=",Qual,", Gatilho Venda = ",GatilhoSell,", TempoGat=",TempoGatilhoSell,",sma=",sma[i],", tempo sma=",Time[i]);
              }
           }
        }
      //if(Qual==2 && )

      // Tem que manter os que ainda não foram acionados...
      //for(int j=4; j>=0; j--)
      //int j=0;
      //{
      if(TempoGatilhoBuy>0)// && (TrendFilter!=-1))
         if(sma[i]>=GatilhoBuy && (GatilhoBuy>0 && GatilhoBuy!=EMPTY_VALUE) && Time[i]>=TempoGatilhoBuy)// && aTendencia!=Tendencia)
           {
            // if((Qual==2 && Trend1!=-1) || Qual!=2)
              {
               Tendencia=1;
               TempoBuy=Time[i];
               if(((dPBO1 && Qual==1)||(dPBO2 && Qual==2)) && aTendencia!=Tendencia)
                 {
                  TempoPBOConfirm = TempoBuy;
                  DesenhaLn(Qual,Tendencia,TempoBuy);
                  //Print("Confirmado: tempo=",Qual,", Gatilho compra = ",GatilhoBuy,", TempoGat=",TempoGatilhoBuy);
                  //Print("sma=",sma[i],", tempo smaBuy=",Time[i]);

                 }
               GatilhoBuy=0;
               aTendencia=Tendencia;
               PrecoAberturaSell=0;
              }
           }
      if(TempoGatilhoSell>0)// && (TrendFilter!=1))
         if(sma[i]<=GatilhoSell && (GatilhoSell>0 && GatilhoSell!=EMPTY_VALUE) && Time[i]>=TempoGatilhoSell)// && aTendencia!=Tendencia
           {
            // if((Qual==2 && Trend1!=1) || Qual!=2)
              {
               Tendencia=-1;
               TempoSell=Time[i];
               if(((dPBO1 && Qual==1)||(dPBO2 && Qual==2)) && aTendencia!=Tendencia)
                 {
                  TempoPBOConfirm=TempoSell;
                  DesenhaLn(Qual,Tendencia,TempoSell);
                  //Print("Confirmado: tempo=",Qual,", Gatilho Venda = ",GatilhoSell,", TempoGat=",TempoGatilhoSell);
                  //Print("sma=",sma[i],", tempo smaSell=",Time[i]);
                  //   aTendencia=Tendencia;
                 }
               GatilhoSell=0;
               aTendencia=Tendencia;
               PrecoAberturaBuy=0;
              }
           }
      //}
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CalculaBarra3(int TendenciaMae,int Trend,datetime timeConf,datetime &dt1,datetime &dt2,double &Preco1,double &Preco2,double &D12)//(int limite,int TendenciaMae,double &Ponto1,datetime &dt1,double &Ponto2,datetime &dt2,datetime &dtSupera,datetime &dtConfirm,double &Preco0618)//Passo3
  {
   bool retval=false;
   int nBarras = 0;
   if(Trend!=1 && Trend!=-1)
      return false;

   if(Trend!=TendenciaMae)
      return false;

   if(Trend==1 && TendenciaMae==1)
     {
      dt2=iTime(m_symbol.Name(),tempo2,1);
      dt1=timeConf;
      //nBarras = Bars(m_symbol.Name(),tempo2,dt1,dt2);
      SinalEntrada=1;
      PrecoAberturaSell=0;

     }
   if(Trend==-1 && TendenciaMae==-1)
     {
      dt2=iTime(m_symbol.Name(),tempo2,1);
      dt1=timeConf;
      //nBarras = Bars(m_symbol.Name(),tempo2,dt1,dt2);
      SinalEntrada=-1;
      PrecoAberturaBuy=0;
     }

   nBarras=CalculaBarras(Trend,dt1,dt2);

//Print("nBarras=",nBarras,", dt2=",dt2,", ",TendenciaMae,", ",Trend);
//Print("dt1=",dt1);

   if(nBarras==3)
     {
      //return false;


      PrecoBE=0;
      PrecoSL=0;

      double //Open[],
      High[1],Low[1];//,Close[];
      /*datetime Time[];
      ArrayResize(uos,limite);
      ArrayResize(Open,limite);
      ArrayResize(High,limite);
      ArrayResize(Low,limite);
      ArrayResize(Close,limite);
      ArrayResize(Time,limite);
      */
      //CopyBuffer(uos_handle3,0,0,limite,uos);
      //CopyOpen(m_symbol.Name(),tempo3,0,limite,Open);
      CopyHigh(m_symbol.Name(),tempo2,1,1,High);
      CopyLow(m_symbol.Name(),tempo2,1,1,Low);
      //CopyClose(m_symbol.Name(),tempo3,0,limite,Close);
      //CopyTime(m_symbol.Name(),tempo3,0,limite,Time);
      retval=false;
      D12=High[0]-Low[0];

      if(Trend>0)
        {
         PrecoAberturaBuy=High[0];
         Preco2=Low[0];
         Preco1=High[0];
         Preco50=PrecoAberturaBuy+D12*fatorFibo;///2;
         pParcial=PrecoAberturaBuy+D12*1.618;
         //TPbuy=PrecoAberturaBuy+(D12*1.618+iMultParcial);
         retval=true;
         //Print("Trend de compra ",retval);
        }

      if(Trend<0)
        {
         PrecoAberturaSell=Low[0];
         Preco2=High[0];
         Preco1=Low[0];
         Preco50=PrecoAberturaSell-D12*fatorFibo;///2;
         pParcial=PrecoAberturaSell-D12*1.618;
         //TPsell=PrecoAberturaSell-(D12*1.618*iMultParcial);
         retval=true;
         //Print("Trend de venda ",retval);
        }
      //Print("É = 3");

      string Recado="";
      Acumulacao();
      if(CancelouAcumulacao)
        {
         Recado="Acumulação cancelou a operação.";
         PrecoAberturaBuy=0;
         PrecoAberturaSell=0;
         Print(Recado);
         return false;
        }
      if(utilGator)
        {
         //double gator0[1],gator1[1],gator2[1],gator3[1];
         double gator1[1],gator3[1];
         //CopyBuffer(gator_handle,0,0,1,gator0);
         CopyBuffer(gator_handle,1,1,1,gator1);
         //CopyBuffer(gator_handle,2,0,1,gator2);
         CopyBuffer(gator_handle,3,11,1,gator3);
         //vermelho = 1
         //verde = 0
         bool podeOperar=false;
         if(gator1[0]==gator3[0])
           {
            if(gator1[0]==0 && Trend1==1)//verde + tendencia de compra
               podeOperar=true;
            if(gator1[0]==1 && Trend1==-1)//vermelho + tendência de venda
               podeOperar=true;
           }
         if(!podeOperar)
           {
            PrecoAberturaBuy=0;
            PrecoAberturaSell=0;
            Recado="Gator cancelou operação.";
            Print(Recado);
            return false;
           }
        }
     }
//if(PrecoOpen>0 && PrecoOpen!=Preco0618 && Superador>0 && Superou>0)
//     {
//Preco0618=PrecoOpen;
//if(dExpansao)
//Print("Preco1=",Preco1,", Preco2=",Preco2,", confirmado em:",dt2," = ",retval);
//}
// else         Preco0618 = 0;
   return retval;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/*
bool NegociaSMA(int Qual,int limite)//Passo5 (igual para os 2 lados)
  {

   bool RetVal=false;

   double High[],Low[],sma[];
   ArrayResize(High,limite);
   ArrayResize(Low,limite);
   ArrayResize(sma,limite);

   switch(Qual)
     {
      case 3:
         CopyBuffer(sma_handle3,0,0,limite,sma);
         CopyHigh(Symbol(),tempo3,0,limite,High);
         CopyLow(Symbol(),tempo3,0,limite,Low);
         break;
      default:
         CopyBuffer(sma_handle3,0,0,limite,sma);
         CopyHigh(Symbol(),tempo3,0,limite,High);
         CopyLow(Symbol(),tempo3,0,limite,Low);
         break;

     }

   for(int i=0; i<limite; i++)
     {
      if(sma[i]>=Low[i] && sma[i]<=High[i])
        {
         RetVal=true;
         return RetVal;
         break;
        }
     }

   return RetVal;
  }*/
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CalculoVolume()
  {
//VolumeFin

   dLote=MathFloor(dLote/PassoVolume)*PassoVolume;
   if(dLote<SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN))
      dLote=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);

   if(dLote>SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX))
      dLote=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);

   double Margem=0;
   if(OrderCalcMargin(ORDER_TYPE_BUY,m_symbol.Name(),dLote,ASK,Margem))
      TTMargem="Margem = "+DoubleToString(Margem,2);


  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AjustaImediato()
  {
   LoteComprado=0;
   LoteVendido=0;
   LucroAbertas=0;
   VerificaPosicoes(LoteComprado,LoteVendido,LucroAbertas);    // OperacoesMkt
//p_Positions_Profit=DoubleToString(LucroAbertas,2);
//p_Buy_Lot=DoubleToString(LoteComprado,dVol);
//p_Sell_Lot=DoubleToString(LoteVendido,dVol);

   /*if((Prossegue & funciona)>0)
     {
      p_Habilitado="true";
     }
   else
      p_Habilitado="false";
   */
//funciona=true;
//Print("Prossegue=",Prossegue,", funciona=",funciona," = ",Prossegue+funciona);

//AtualizaTela();
   ChartRedraw(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void VerificaPosicoes(double &fLoteComprado,double &fLoteVendido,double &fLucroAbertas)
  {
//if(VerificaOp)Print(__FUNCTION__);
   fLoteComprado=0;
   fLoteVendido=0;
   fLucroAbertas=0;
   double SLatual=0;
   double PrecoEntrada=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong    position_ticket   = PositionGetTicket(i);                // bilhete da posição
      long     Pmagic            = PositionGetInteger(POSITION_MAGIC);  // MagicNumber da posição
      string   PAberta           = PositionGetSymbol(i);
      long     TipoOrdem         = PositionGetInteger(POSITION_TYPE);   // Tipo
      double   Profit            = PositionGetDouble(POSITION_PROFIT);
      double   Volume            = PositionGetDouble(POSITION_VOLUME);
      if(Pmagic == nMAGIC && PAberta==m_symbol.Name())
        {
         SLatual=PositionGetDouble(POSITION_SL);
         PrecoEntrada=PositionGetDouble(POSITION_PRICE_OPEN);
         fLucroAbertas+=Profit;
         if(TipoOrdem == POSITION_TYPE_BUY)
           {
            fLoteComprado+=Volume;
           }
         if(TipoOrdem == POSITION_TYPE_SELL)
           {
            fLoteVendido+=Volume;
           }
        }
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
/*
void VerificaStops()//double &fLoteComprado,double &fLoteVendido,double &fLucroAbertas)
  {
//if(VerificaOp)Print(__FUNCTION__);

   Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol;

   double SLatual=0,TPatual=0;
   double PrecoEntrada=0;
   double d1=-1;
   double nD=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong    position_ticket   = PositionGetTicket(i);                // bilhete da posição
      long     Pmagic            = PositionGetInteger(POSITION_MAGIC);  // MagicNumber da posição
      string   PAberta           = PositionGetSymbol(i);
      long     TipoOrdem         = PositionGetInteger(POSITION_TYPE);   // Tipo
      double   Profit            = PositionGetDouble(POSITION_PROFIT);
      double   Volume            = PositionGetDouble(POSITION_VOLUME);
      if(Pmagic == nMAGIC && PAberta==m_symbol.Name())
        {
         SLatual=PositionGetDouble(POSITION_SL);
         TPatual=PositionGetDouble(POSITION_TP);
         PrecoEntrada=PositionGetDouble(POSITION_PRICE_OPEN);

         if(TipoOrdem == POSITION_TYPE_BUY)
           {
            d1=ASK-PrecoEntrada;
            nD=MathFloor(d1/PassoDistancia);
            // Print("1. nd=",nD);
            //fLoteComprado+=Volume;
            if(Volume>=dLote && BID>=PrecoBE)
              {
               PrecoEntrada=NormalizeDouble(PrecoEntrada,_Digits);
               //Parcial
               if(!m_trade.PositionClosePartial(position_ticket,VolParcial))
                  Print("Falha na saída parcial.");

               if(SLatual<=PrecoEntrada)
                 {
                  if(!m_trade.PositionModify(position_ticket,PrecoEntrada,TPatual))
                     Print("Falha ao iniciar o BreakEven.");
                  else
                    {
                     Print("Passo12: BreakEven");
                    }
                 }
              }
            if(nD>1)
              {
               if(ASK>=PrecoEntrada+nD*PassoDistancia)
                 {
                  double NovoSL=PrecoEntrada+((nD-1)*PassoDistancia);
                  NovoSL=MathFloor(NovoSL/divSymbol)*divSymbol;
                  NovoSL=NormalizeDouble(NovoSL,_Digits);
                  if(SLatual<NovoSL-Espaco  || SLatual==0)
                    {
                     if(!m_trade.PositionModify(position_ticket,NovoSL,TPatual))
                        Print("Falha na tentativa de alterar o SL");
                    }
                 }
              }

           }
         if(TipoOrdem == POSITION_TYPE_SELL)
           {
            d1=PrecoEntrada-BID;
            //Print("PrecoEntrada=",PrecoEntrada,", BID=",BID);
            nD=MathFloor(d1/PassoDistancia);
            //fLoteVendido+=Volume;
            //Print("2. nd=",nD);
            if(Volume>=dLote && ASK<=PrecoBE)
              {
               PrecoEntrada=NormalizeDouble(PrecoEntrada,_Digits);
               //Parcial
               if(!m_trade.PositionClosePartial(position_ticket,VolParcial))
                  Print("Falha na saída parcial.");
               if(SLatual>=PrecoEntrada)
                 {
                  if(!m_trade.PositionModify(position_ticket,PrecoEntrada,TPatual))
                     Print("Falha ao iniciar o BreakEven.");
                  else
                    {
                     Print("Passo12: BreakEven");
                    }
                 }
              }
            if(nD>1)
              {
               if(BID<=PrecoEntrada-nD*PassoDistancia)
                 {
                  double NovoSL=PrecoEntrada-((nD-1)*PassoDistancia);
                  NovoSL=MathCeil(NovoSL/divSymbol)*divSymbol;
                  NovoSL=NormalizeDouble(NovoSL,_Digits);
                  if(SLatual>NovoSL+Espaco || SLatual==0)
                    {
                     if(!m_trade.PositionModify(position_ticket,NovoSL,TPatual))
                        Print("Falha na tentativa de alterar o SL");
                    }
                 }
              }

           }
        }
     }
  }
*/
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CalculaHorario()
  {
   Iniciar=iIniHr*100+iIniMn;
//Iniciar=0;
   Finalizar=iFnlHr*100+iFnlMn;
//Finalizar=0;
   Derrubar=Finalizar+iDerr;
//Derrubar=0;
//funciona=false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Agora()
  {
   TimeCurrent(mdt2);
   switch(LocalTime)
     {
      case HoraLocal:
         dAgora=TimeLocal(mdt1);
         break;
      case HoraCorrente:
         dAgora=TimeCurrent(mdt1);
         break;
      default: // gmt
         dAgora=TimeGMT(mdt1);
         break;
     }

   lAgora   = mdt1.hour*100+mdt1.min;
   Hoje     = mdt1.year*10000+mdt1.mon*100+mdt1.day;
   dHoje    = StringSubstr((string)dAgora,0,10);
   dHojeBroker=StringSubstr((string)TimeCurrent(mdt1),0,10);

   bool VerifFuncionamento=Funcionamento();

   if(!funciona && VerifFuncionamento)
      funciona = true;
   if(funciona && !VerifFuncionamento)
      funciona = false;

//Print("Funciona=",funciona);
   if(Ontem!=Hoje)
     {
      Ontem=Hoje;
      //Prossegue=true;
      Print("Virou o dia!");
      //ViraDia();//Tem que ter no robô principal

     }


  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Funcionamento()
  {
   if(Iniciar==Finalizar)
      return true;



   if(Iniciar<Finalizar)
     {
      if(lAgora>Iniciar && lAgora<Finalizar)
         return true;
      else //if(lAgora>Iniciar && lAgora>Finalizar)
        {
         if(lAgora>Derrubar && LoteComprado+LoteVendido>0 && Derrubar!=0)
            FechaTudo();
         return false;
        }
     }
   else
     {
      if(lAgora>Iniciar || lAgora<Finalizar)
         return true;
      else
        {
         if(lAgora>Derrubar && LoteComprado+LoteVendido>0 && Derrubar!=0)
            FechaTudo();
         return false;
        }
     }


   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void FechaTudo()
  {
//if(VerificaOp)      Print(__FUNCTION__);
   bool Retorno=true;
   MqlTradeRequest request;
//if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))return ;
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong    position_ticket   = PositionGetTicket(i);                // bilhete da posição
      long     Pmagic            = PositionGetInteger(POSITION_MAGIC);  // MagicNumber da posição
      string   PAberta           = PositionGetSymbol(i);
      long     TipoOrdem         = PositionGetInteger(POSITION_TYPE);   // Tipo
      //double   Profit            = PositionGetDouble(POSITION_PROFIT);
      double   Volume            = PositionGetDouble(POSITION_VOLUME);
      if(Pmagic == nMAGIC && PAberta==m_symbol.Name())
        {
         if(TipoOrdem == POSITION_TYPE_BUY)
           {
            if(!m_trade.PositionClose(position_ticket))
              {
               Print("Close buy order failed ("+PAberta+"). Start trailing stop...");
               DeveSairCompra=true;
               //Recado="Fechamento não aconteceu.";
               Retorno=false;
              }
           }
         if(TipoOrdem == POSITION_TYPE_SELL)
           {
            if(!m_trade.PositionClose(position_ticket))
              {
               Print("Close sell order failed ("+PAberta+"). Start traling stop...");
               DeveSairVenda=true;
               // Recado="Fechamento não aconteceu.";
               Retorno=false;
              }
           }
        }
     }


   if(Retorno && (DeveSairCompra || DeveSairVenda))
     {
      DeveSairCompra=false;
      DeveSairVenda=false;
     }

   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      ulong order_ticket=OrderGetTicket(i);
      long Pmagic=OrderGetInteger(ORDER_MAGIC);
      string PAberta=OrderGetString(ORDER_SYMBOL);
      if(Pmagic==nMAGIC && PAberta==m_symbol.Name())
        {
         if(!m_trade.OrderDelete(order_ticket))
           {
            //Recado="Ordem não cancelada.";
           }
        }

     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ArrastaSLgrudado(int Tipo)
  {
//if(VerificaOp)      Print(__FUNCTION__);
//if(Tipo==1)compra
//if(Tipo==-1)venda

//bool Retorno=true;
// if(VerificaFinal)      Print(__FUNCTION__);

   double nPrecoSL=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong    position_ticket   = PositionGetTicket(i);                // bilhete da posição
      long     Pmagic            = PositionGetInteger(POSITION_MAGIC);  // MagicNumber da posição
      string   PAberta           = PositionGetSymbol(i);
      long     TipoOrdem         = PositionGetInteger(POSITION_TYPE);   // Tipo
      //double   Profit            = PositionGetDouble(POSITION_PROFIT);
      double preco = ASK;//PositionGetDouble(POSITION_PRICE_OPEN);
      double   Volume            = PositionGetDouble(POSITION_VOLUME);
      double SL=PositionGetDouble(POSITION_SL);
      double TP=PositionGetDouble(POSITION_TP);
      if(Pmagic == nMAGIC && PAberta==m_symbol.Name())
        {
         if(TipoOrdem == POSITION_TYPE_BUY && Tipo==1)
           {
            preco=BID;
            nPrecoSL=MathFloor((preco-Espaco-divSymbol)/divSymbol)*divSymbol;
            nPrecoSL=NormalizeDouble(nPrecoSL,m_symbol.Digits());
            //if(VerificaFinal)               Print("Novosl=",PrecoSL);
            if(nPrecoSL<BID-Espaco && (nPrecoSL>=SL+Espaco || SL==0))
              {
               if(!m_trade.PositionModify(position_ticket,nPrecoSL,TP))
                 {
                  Print("Trailing stop failed. Order: ",position_ticket);
                 }
              }
           }
         if(TipoOrdem == POSITION_TYPE_SELL && Tipo==-1)
           {
            nPrecoSL=MathCeil((ASK+Espaco+divSymbol)/divSymbol)*divSymbol;
            nPrecoSL=NormalizeDouble(nPrecoSL,m_symbol.Digits());
            //if(VerificaFinal)               Print("Novosl=",PrecoSL);
            if(nPrecoSL>ASK+Espaco && (nPrecoSL<SL-Espaco || SL==0))
              {
               if(!m_trade.PositionModify(position_ticket,nPrecoSL,TP))
                 {
                  Print("Trailing stop failed. Order: ",position_ticket);
                 }
              }
            //else {}
           }
        }
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DesenhaLn(int Qual,int Trend,datetime Data)
  {
   MqlDateTime mqln;
   TimeToStruct(Data,mqln);
   long nLn=mqln.year*100000000+mqln.mon*1000000+mqln.day*10000+mqln.hour*100+mqln.min;

   if(Trend==1)
     {
      switch(Qual)
        {
         case 1:
            LnB1=nLn;
            if(ObjectFind(0,"PBOCompra1_"+IntegerToString(LnB1))>=0)
               return;
            ObjectCreate(0,"PBOCompra1_"+IntegerToString(LnB1),OBJ_VLINE,0,Data,ASK);
            ObjectSetInteger(0,"PBOCompra1_"+IntegerToString(LnB1),OBJPROP_COLOR,clr_buyTrend1);
            ObjectSetInteger(0,"PBOCompra1_"+IntegerToString(LnB1),OBJPROP_STYLE,STYLE_DASHDOT);
            //LnB1++;
            break;
         case 2:

            LnB2=nLn;
            if(ObjectFind(0,"PBOCompra2_"+IntegerToString(LnB2))>=0)
               return;
            ObjectCreate(0,"PBOCompra2_"+IntegerToString(LnB2),OBJ_VLINE,0,Data,ASK);
            ObjectSetInteger(0,"PBOCompra2_"+IntegerToString(LnB2),OBJPROP_COLOR,clr_buyTrend2);
            ObjectSetInteger(0,"PBOCompra2_"+IntegerToString(LnB2),OBJPROP_STYLE,STYLE_DASHDOT);
            //LnB2++;
            break;
         default://case 3:
            /*
                        LnB3=nLn;
                        if(ObjectFind(0,"PBOCompra3_"+IntegerToString(LnB3))>=0)
                           return;
                        ObjectCreate(0,"PBOCompra3_"+IntegerToString(LnB3),OBJ_VLINE,0,Data,ASK);
                        ObjectSetInteger(0,"PBOCompra3_"+IntegerToString(LnB3),OBJPROP_COLOR,clr_buyTrend3);
                        ObjectSetInteger(0,"PBOCompra3_"+IntegerToString(LnB3),OBJPROP_STYLE,STYLE_DASHDOT);
                        //LnB3++;
                        */
            break;
        }
     }

   if(Trend==-1)
     {
      switch(Qual)
        {
         case 1:
            LnS1=nLn;
            if(ObjectFind(0,"PBOVenda1_"+IntegerToString(LnS1))>=0)
               return;
            ObjectCreate(0,"PBOVenda1_"+IntegerToString(LnS1),OBJ_VLINE,0,Data,BID);
            ObjectSetInteger(0,"PBOVenda1_"+IntegerToString(LnS1),OBJPROP_COLOR,clr_sellTrend1);
            ObjectSetInteger(0,"PBOVenda1_"+IntegerToString(LnS1),OBJPROP_STYLE,STYLE_DASHDOT);
            //LnS1++;
            break;
         case 2:
            LnS2=nLn;
            if(ObjectFind(0,"PBOVenda2_"+IntegerToString(LnS2))>=0)
               return;
            ObjectCreate(0,"PBOVenda2_"+IntegerToString(LnS2),OBJ_VLINE,0,Data,BID);
            ObjectSetInteger(0,"PBOVenda2_"+IntegerToString(LnS2),OBJPROP_COLOR,clr_sellTrend2);
            ObjectSetInteger(0,"PBOVenda2_"+IntegerToString(LnS2),OBJPROP_STYLE,STYLE_DASHDOT);
            //LnS2++;
            break;
         default://case 3:
            /*
                        LnS3=nLn;
                        if(ObjectFind(0,"PBOVenda3_"+IntegerToString(LnS3))>=0)
                           return;
                        ObjectCreate(0,"PBOVenda3_"+IntegerToString(LnS3),OBJ_VLINE,0,Data,BID);
                        ObjectSetInteger(0,"PBOVenda3_"+IntegerToString(LnS3),OBJPROP_COLOR,clr_sellTrend3);
                        ObjectSetInteger(0,"PBOVenda3_"+IntegerToString(LnS3),OBJPROP_STYLE,STYLE_DASHDOT);
                        //LnS3++;
                        */
            break;
        }
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void LimpaIndicadores()
  {
   long total_windows=ChartGetInteger(0,CHART_WINDOWS_TOTAL);
//Print("total_windows=",total_windows);
   string name;

   for(int j=0; j<ChartIndicatorsTotal(0,0); j++)
     {
      name=ChartIndicatorName(0,0,j);
      //if(!
      ChartIndicatorDelete(0,0,name);//)
      //Print("Não foi possível remover ",name);
     }

   while(total_windows>1)
     {



      for(int i=0; i<total_windows; i++)
        {
         for(int j=0; j<ChartIndicatorsTotal(0,i); j++)
           {
            name=ChartIndicatorName(0,i,j);
            ChartIndicatorDelete(0,i,name);//)
           }
        }
      total_windows=ChartGetInteger(0,CHART_WINDOWS_TOTAL);
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Retracao(int Tendencia,datetime dt1,datetime dt2,double Ponto1,double Ponto2,double D12)//Passo3 //Passo8
  {

//Print("H=",H,", L=",L);
//posicionamento da retração no ponto maximo e minimo do candle que confirma pbo1 (0, entrada, 1.618 alvo, 0.5 breakeven, -1 estope)

   int Chart=0;
   /*int nBarras=Bars(m_symbol.Name(),tempo2,dt1,dt2);
   if(nBarras!=4)
      return;
   */
//if(LoteComprado+LoteVendido==0 && Operou)      Operou=false;


   if(Ponto1+Ponto2!=0)
     {
      //Preco50=(Ponto1+Ponto2)/2;
      MqlDateTime mdtR;
      TimeToStruct(dt1,mdtR);
      string Retr="Retracao"+IntegerToString(mdtR.year*100000000+mdtR.mon*1000000+mdtR.day*10000+mdtR.hour*100+mdtR.min);

      if(Tendencia>0)
        {
         PrecoAberturaSell=0;
         SLbuy = MathFloor((PrecoAberturaBuy-(D12*1.618))/divSymbol)*divSymbol;
         SLbuy=NormalizeDouble(SLbuy,m_symbol.Digits());
         TPbuy=MathFloor((PrecoAberturaBuy+(D12*1.618*iMultParcial))/divSymbol)*divSymbol;
         TPbuy = NormalizeDouble(TPbuy,m_symbol.Digits());
         //TPbuy= MathFloor((PrecoAberturaBuy+(D12))/divSymbol)*divSymbol;
         //Print("PrecoBuy=",PrecoAberturaBuy,", SLbuy=",SLbuy);
        }
      if(Tendencia<0)
        {
         PrecoAberturaBuy=0;
         SLsell = MathCeil((PrecoAberturaSell+(D12*1.618))/divSymbol)*divSymbol;
         SLsell=NormalizeDouble(SLsell,m_symbol.Digits());
         TPsell= MathCeil((PrecoAberturaSell-(D12*1.618*iMultParcial))/divSymbol)*divSymbol;
         TPsell=NormalizeDouble(TPsell,m_symbol.Digits());

         //Print("PrecoSell=",PrecoAberturaSell,", SLsell=",SLsell);
        }


      if(ObjectFind(Chart,Retr)<0)
        {
         ObjectCreate(Chart,Retr,OBJ_FIBO,0,dt1,Ponto1,dt2,Ponto2);
         /* if(Cancelou5)
            {
             Cancelou5=false;
             ValorPasso5="-";
            }*/
         ChartRedraw(0);
        }
     }


  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CalculaBarras(int Trend,datetime dt1,datetime dt2)
  {
   int retval=0;

   int limite=Bars(m_symbol.Name(),tempo2,dt1,dt2);
   if(limite<3)
      return retval;

   double Close[],sma[];
//datetime Time[];
   ArrayResize(Close,limite);
   ArrayResize(sma,limite);

   CopyClose(m_symbol.Name(),tempo2,1,limite,Close);
   CopyBuffer(sma_handle2,0,1,limite,sma);

   for(int i=1; i<limite; i++)
     {
      if((Close[i]>sma[i] && Trend==-1) || (Close[i]<sma[i] && Trend==1))
         retval++;

      if(retval==3 && i<limite-1)
         retval++;
     }


   return retval;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Acumulacao()//Passo6: Acumulação
  {

   if(!iAcumulacao)
     {
      return;
     }
   double ATR3[3];
   CopyBuffer(atr_handle2,0,1,3,ATR3);

//if(ATR3[0]>=ATR3[1] && ATR3[1]>=ATR3[2])
   if(ATR3[1]>=ATR3[2])
     {

      CancelouAcumulacao=true;
     }
   else
      CancelouAcumulacao=false;

   /*if(Cancelou6)
      ValorPasso6="Cancelado";
   else
      ValorPasso6="-";
   */

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void VerificaStops()
  {

   if(!trade_session())
      return;

   if(!RefreshRates())
      return;

   string Recado="";
   Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol;// + 2*divSymbol;

   double ATR1[1];
   CopyBuffer(atr_handle2,0,0,1,ATR1);
   if(ATR1[0]<=0)
      return;
   double low1 = iLow(Symbol(),tempo2,1);
   double high1 = iHigh(Symbol(),tempo2,1);
   double low0 = iLow(Symbol(),tempo2,0);
   double high0 = iHigh(Symbol(),tempo2,0);

   double close1=iClose(Symbol(),tempo2,1);
   double low2 = iLow(Symbol(),tempo2,2);
   double high2 = iHigh(Symbol(),tempo2,2);
//Após acionar o Breakeven, a cada candle que fechar acima da máxima anterior o Trailing sobe 1 tic da mínima do candle.



   Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol + 2*divSymbol;
   double nPrecoSL=0;
   double preco=0,preco0=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong    position_ticket   = PositionGetTicket(i);                // bilhete da posição
      long     Pmagic            = PositionGetInteger(POSITION_MAGIC);  // MagicNumber da posição
      string   PAberta           = PositionGetSymbol(i);
      long     TipoOrdem         = PositionGetInteger(POSITION_TYPE);   // Tipo
      double   precoEntrada      = PositionGetDouble(POSITION_PRICE_OPEN);
      double   Volume            = PositionGetDouble(POSITION_VOLUME);
      double   SL                = PositionGetDouble(POSITION_SL);
      double   TP                = PositionGetDouble(POSITION_TP);
      if(Pmagic == nMAGIC && PAberta==m_symbol.Name())
        {

         if(TipoOrdem == POSITION_TYPE_BUY)
           {
            preco=BID;
            preco0 = high0;

            if(UtilizarBE)
              {


                 {
                  if(preco>=precoEntrada+(ATR1[0]*fatorATR) || preco0>=high1-divSymbol*ifatorBE || preco0>=oPreco50)//isso é só o breakeven
                    {
                     //                    iMultParcial
                     nPrecoSL=NormalizeDouble(precoEntrada,m_symbol.Digits());
                     //if(VerificaFinal)               Print("Novosl=",PrecoSL);
                     if(nPrecoSL<BID-Espaco && nPrecoSL>=SL+Espaco && SL!=precoEntrada)// || SL==0))
                       {
                        if(!m_trade.PositionModify(position_ticket,nPrecoSL,TP))
                          {
                           Recado="Falhou Breakeven. [01]";// Order: "+IntegerToString(position_ticket);
                           //if(PrintRecado)
                           Print(Recado);
                          }
                        else
                          {
                           Recado="Breakeven ok.";
                           //if(PrintRecado)
                           SL=nPrecoSL;
                           Print(Recado);

                           //Print(Recado,",Part1= ",Part1,", dLoteP1=",dLoteP1,", volume=", Volume,", minimo=",VolumeMinimo);
                          }
                       }
                    }
                 }
               //trailing + BE
               if(close1>high2 && SL>=precoEntrada)
                 {
                  nPrecoSL=MathFloor((low2-divSymbol)/divSymbol)*divSymbol;

                  nPrecoSL=NormalizeDouble(nPrecoSL,m_symbol.Digits());
                  if(nPrecoSL<BID-Espaco && nPrecoSL>=SL+Espaco && SL!=nPrecoSL)
                    {
                     if(!m_trade.PositionModify(position_ticket,nPrecoSL,TP))
                       {
                        Recado="Falhou Trailing Stop. [07]";// Order: "+IntegerToString(position_ticket);
                        //if(PrintRecado)
                        Print(Recado);
                       }
                     else
                       {
                        Recado="Trailing Stop ok. [08]";
                        SL=nPrecoSL;
                        //if(PrintRecado)
                        Print(Recado);
                        //Print(Recado,",Part1= ",Part1,", dLoteP1=",dLoteP1,", volume=", Volume,", minimo=",VolumeMinimo);
                       }
                    }
                 }
               //if(close1<low2)NovoSL=MathCeil((high2+divSymbol)/divSymbol)*divSymbol;

              }
            else
              {
               //trailing sem BE
               if(close1>high2)
                 {
                  nPrecoSL=MathFloor((low2-divSymbol)/divSymbol)*divSymbol;

                  nPrecoSL=NormalizeDouble(nPrecoSL,m_symbol.Digits());
                  if(nPrecoSL<BID-Espaco && nPrecoSL>=SL+Espaco && SL!=nPrecoSL)
                    {
                     if(!m_trade.PositionModify(position_ticket,nPrecoSL,TP))
                       {
                        Recado="Falhou Trailing Stop. [07.2]";// Order: "+IntegerToString(position_ticket);
                        //if(PrintRecado)
                        Print(Recado);
                       }
                     else
                       {
                        Recado="Trailing Stop ok. [08.2]";
                        //if(PrintRecado)
                        SL=nPrecoSL;
                        Print(Recado);
                        //Print(Recado,",Part1= ",Part1,", dLoteP1=",dLoteP1,", volume=", Volume,", minimo=",VolumeMinimo);
                       }
                    }
                 }

              }

            if(preco>=oParcial && oParcial>0.0)//Comparação para realizar a Parcial, que é 1.618 da régua.(oParcial)
              {
               if(iSaidaNaParcial)
                 {
                  FechaTudo();
                 }
               else
                 {
                  if(VolParcial>0)
                    {
                     if(!m_trade.PositionClosePartial(position_ticket,VolParcial))
                        Print("Falha no fechamento parcial");
                     else
                       {
                        oParcial=0.0;
                        Print("Parcial Ok");
                       }
                    }
                 }
              }
           }
         if(TipoOrdem == POSITION_TYPE_SELL)
           {
            preco=ASK;
            preco0 = low0;
            if(UtilizarBE)
              {
               //if(preco>precoEntrada+(ATR1[0]*fatorATR) || preco0>=high1-divSymbol*fatorBE || preco0>oPreco50-divSymbol*fatorBE)

                 {
                  if(preco<=precoEntrada-(ATR1[0]*fatorATR) || preco0<=low1+divSymbol*ifatorBE || preco0<=oPreco50)
                    {
                     nPrecoSL=NormalizeDouble(precoEntrada,m_symbol.Digits());
                     //if(VerificaFinal)               Print("Novosl=",PrecoSL);
                     if(nPrecoSL>ASK+Espaco && nPrecoSL<=SL-Espaco && SL!=precoEntrada)// || SL==0))
                       {
                        if(!m_trade.PositionModify(position_ticket,nPrecoSL,TP))
                          {
                           Recado="Falhou Breakeven. [02]";// Order: "+IntegerToString(position_ticket);
                           //if(PrintRecado)
                           Print(Recado);
                          }
                        else
                          {
                           Recado="Breakeven ok.";
                           SL=nPrecoSL;
                           //if(PrintRecado)
                           Print(Recado);
                         
                           //Print(Recado);
                           //Print(Recado,",Part1= ",Part1,", dLoteP1=",dLoteP1,", volume=", Volume,", minimo=",VolumeMinimo);
                          }

                       }
                    }
                 }
               //trailing + BE
               if(close1<low2 && SL<=precoEntrada)
                 {
                  nPrecoSL=MathCeil((high2+divSymbol)/divSymbol)*divSymbol;

                  nPrecoSL=NormalizeDouble(nPrecoSL,m_symbol.Digits());
                  if(nPrecoSL>ASK+Espaco && nPrecoSL<=SL-Espaco && SL!=nPrecoSL)
                    {
                     if(!m_trade.PositionModify(position_ticket,nPrecoSL,TP))
                       {
                        Recado="Falhou Trailing Stop. [09]";// Order: "+IntegerToString(position_ticket);
                        //if(PrintRecado)
                        Print(Recado);
                       }
                     else
                       {
                        Recado="Trailing Stop ok. [10]";
                        SL=nPrecoSL;
                        //if(PrintRecado)
                        Print(Recado);
                        //Print(Recado,",Part1= ",Part1,", dLoteP1=",dLoteP1,", volume=", Volume,", minimo=",VolumeMinimo);
                       }
                    }
                 }
               //if(close1<low2)NovoSL=MathCeil((high2+divSymbol)/divSymbol)*divSymbol;

              }
            else
              {
               //trailing sem BE
               if(close1>high2)
                 {
                  nPrecoSL=MathFloor((low2-divSymbol)/divSymbol)*divSymbol;

                  nPrecoSL=NormalizeDouble(nPrecoSL,m_symbol.Digits());
                  if(nPrecoSL<BID-Espaco && nPrecoSL>=SL+Espaco && SL!=nPrecoSL)
                    {
                     if(!m_trade.PositionModify(position_ticket,nPrecoSL,TP))
                       {
                        Recado="Falhou Trailing Stop. [11]";// Order: "+IntegerToString(position_ticket);
                        //if(PrintRecado)
                        Print(Recado);
                       }
                     else
                       {
                        Recado="Trailing Stop ok. [12]";
                        //if(PrintRecado)
                        SL=nPrecoSL;
                        Print(Recado);
                        //Print(Recado,",Part1= ",Part1,", dLoteP1=",dLoteP1,", volume=", Volume,", minimo=",VolumeMinimo);
                       }
                    }
                 }
              }
              if(preco<=oParcial && oParcial>0.0)//Comparação para realizar a Parcial, que é 1.618 da régua.(oParcial)
              {
               if(iSaidaNaParcial)
                 {
                  FechaTudo();
                 }
               else
                 {
                  if(VolParcial>0)
                    {
                     if(!m_trade.PositionClosePartial(position_ticket,VolParcial))
                        Print("Falha no fechamento parcial");
                     else
                       {
                        oParcial=0.0;
                        Print("Parcial Ok");
                       }
                    }
                 }
              }
           }
        }
     }

  }
//+------------------------------------------------------------------+
