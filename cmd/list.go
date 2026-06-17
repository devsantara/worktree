package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var listCmd = &cobra.Command{
	Use:   "list",
	Short: "List all worktrees",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Running list command")
	},
}

func init() {
	rootCmd.AddCommand(listCmd)
}
