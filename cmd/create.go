package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var createCmd = &cobra.Command{
	Use:   "create",
	Short: "Create a new worktree",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Running create command")
	},
}

func init() {
	rootCmd.AddCommand(createCmd)
}
