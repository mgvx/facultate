using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Controller
{
    using Repository;
    using Model;
    class MyController : IController
    {
        IRepository repo;

        public MyController(IRepository r)
        {
            repo = r;
        }
        public void runTests()
        {
            IStatement ex1 = new StmComp(new StmAssign("v",new ExpConst(2)), new StmPrint(new ExpVar("v")));
		    IStatement ex2 = new StmComp(new StmAssign("a", new ExpArithm('+', new ExpConst(2), new ExpArithm('*', new ExpConst(3),
                            new ExpConst(5)))), new StmComp(new StmAssign("b", new ExpArithm('+', new ExpVar("a"), new ExpConst(1))),
                            new StmPrint(new ExpVar("b"))));
            IStatement ex3 = new StmComp(new StmAssign("a", new ExpArithm('-', new ExpConst(2), new ExpConst(2))), new StmComp(
                            new StmIf(new ExpVar("a"), new StmAssign("v", new ExpConst(2)), new StmAssign("v", new ExpConst(3))),
                            new StmPrint(new ExpVar("v"))));
            IStatement ex6 = new StmComp(new StmOpenRFile("f", "test.in"), new StmComp(new StmReadRFile(new ExpVar("f"), "c"),
                        new StmComp(new StmPrint(new ExpVar("c")), new StmComp(new StmReadRFile(new ExpVar("f"), "c"),
                        new StmComp(new StmPrint(new ExpVar("c")), new StmCloseRFile(new ExpVar("f")))))));
            
            loadInput(ex1);
            allStep();
            loadInput(ex2);
            allStep();
            loadInput(ex3);
            allStep();
            loadInput(ex6);
            allStep();
        }

        void loadInput(IStatement input)
        {
            System.Console.WriteLine("\n...... LOADING: " + input.ToString() + '\n');
            repo.clearAll();

            IStack<IStatement> exe_stack = new MyStack<IStatement>();
            IMap<string,int> sym_table = new MyMap<string,int>();
            IMap<int,FileTuple> files_table = new MyMap<int,FileTuple>();
            IList<int> out_stream = new MyList<int>();

            exe_stack.push(input);
            PState state = new PState(exe_stack, sym_table, out_stream,files_table);

            repo.addPState(state);
        }
        public PState runStep(PState state)
        {
            IStack <IStatement> stk = state.getStack();
		    // error
		    if (stk.isEmpty()) {
                throw new MyException("CON_ERR: reached empty stack");
            }		
		    try {
                IStatement stm = stk.pop();
                return stm.execute(state);
            }
            catch(MyException myEx)
            {
                throw new MyException("EVAL_ERR: \\ " + myEx.Message);
            }
        }
        public void allStep()
        {
		    try {
                PState state = repo.getPState();
                // print
                System.Console.WriteLine(state.ToString());
                while (!state.getStack().isEmpty())
                {
                    runStep(state);
                    // print
                    System.Console.WriteLine(state.ToString());
                }
            }
            catch(MyException myEx)
            {
                throw new MyException("CON_ERR: run step \\ " + myEx.Message);
            }
        }

    }
}
