using System.Runtime.InteropServices;
using WindowsDesktop;



class Program
{
    [DllImport("user32.dll")] private static extern IntPtr GetForegroundWindow();

    private static int RealIndex(int index)
    {
        if (index == 0)
            return 9;

        return index - 1;
    }

    [STAThread]
    public static int Main(string[] args)
    {
        if (args[0] == "prepare")
        {
            while (VirtualDesktop.GetDesktops().Length < 10)
                VirtualDesktop.Create();
            return 0;
        }
        if (args[0] == "switch")
        {
            var desktops = VirtualDesktop.GetDesktops();
            desktops[RealIndex(int.Parse(args[1]))].Switch();
            return 0;
        }
        if (args[0] == "move")
        {
            var desktops = VirtualDesktop.GetDesktops();
            var targetDesktop = desktops[RealIndex(int.Parse(args[1]))];
            VirtualDesktop.MoveToDesktop(GetForegroundWindow(), targetDesktop);
        }

        return 1;
    }
}

